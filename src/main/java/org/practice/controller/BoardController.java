package org.practice.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import org.practice.domain.BoardVO;
import org.practice.domain.FileVO;
import org.practice.domain.MapVO;
import org.practice.domain.PageDTO;
import org.practice.domain.Pager;
import org.practice.domain.ReplyVO;
import org.practice.mapper.UploadMapper;
import org.practice.service.BoardService;
import org.practice.service.MapService;
import org.practice.service.ReplyService;
import org.practice.service.UploadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping(value = "/board")
@PreAuthorize("isAuthenticated()")
public class BoardController {
	
	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	@Setter(onMethod_ = @Autowired)
	private ReplyService reply_service;
	
	@Setter(onMethod_ = @Autowired)
	private UploadService upload_service;
	
	@Setter(onMethod_ = @Autowired)
	private MapService map_service;
	

	@GetMapping("/list")
	public void list(@RequestParam(value="div")int div, Pager p, Model model) {
	
		log.info("=============================");
		log.info("@Controller, BOARD Controller -> Get Board List with Paging: " + p + " Div = " + div);
		log.info("=============================");
		
		model.addAttribute("list", service.getList(div, p));
		model.addAttribute("notice", service.getNotices(div));
		model.addAttribute("pageMaker", new PageDTO(p, service.getTotal(div, p)));
		model.addAttribute("divis", div);
	}
	
	@GetMapping("/write")
	public void write(int div, Model model) {
		
		log.info("# Board Write Page");
		model.addAttribute("division", div);
	}
	@PostMapping("/write")
	@Transactional
	public String write(BoardVO board, MapVO map, @RequestParam(name="uploadFile") MultipartFile[] uploadFile, 
			RedirectAttributes rttr) {
		
		log.info("================================");
		log.info("@Controller - BoardVO : " + board);
		log.info("MapVO map : " + map);
		service.write(board);
		if(!map.getLat().equals("") || map.getLat() != null)
			map_service.insert(map);
		
		if(uploadFile[0].getSize() != 0) {
			fileUpload(uploadFile, 0);
		}
		log.info("================================");
		
		rttr.addFlashAttribute("msg", "Write Success");
		
		return "redirect:/board/list?div=" + board.getDiv();
	}
	
	@GetMapping({"/get"})
	@Transactional
	public void get(@RequestParam("bno")int bno, @ModelAttribute("p") Pager p, Model model) {
		
		log.info("===============================");
		log.info("@Controller, Board Get Bno : " + bno);
		log.info("===============================");
		
		BoardVO board = service.get(bno);
		
		service.hit(bno);
		model.addAttribute("board", board);
		model.addAttribute("reply", reply_service.list(bno));
		model.addAttribute("map", map_service.show(bno));
		//model.addAttribute("p", p);
		
		String next = service.getNextBno(bno, board.getDiv()); //�Խñ��� ���� ��
		String prev = service.getPrevBno(bno, board.getDiv()); //�Խñ��� ���� ��
		if(next != null)
			model.addAttribute("next", next);
		if(prev != null)
			model.addAttribute("prev", prev);
	}
	
	@GetMapping({"/update"})
	public void update(int bno, @ModelAttribute("p") Pager p, Model model) {
		
		log.info("===============================");
		log.info("@Controller, Board Update Bno : " + bno);
		log.info("===============================");
		
		model.addAttribute("board", service.get(bno));
		//model.addAttribute("file", upload_service.getFileList(bno));
	}
	@PostMapping("/update")
	public String update(BoardVO board, @ModelAttribute("p") Pager p, @RequestParam("uploadFile") MultipartFile[] uploadFile, RedirectAttributes rttr) {
		log.info("=============================");
		log.info("# Pager : " + p);
		
		if(service.update(board)) {
			
			if(uploadFile[0].getSize() != 0) {
				fileUpload(uploadFile, board.getBno());
			}
			log.info("Update Board : " + board);
		}
		else {
			log.info("Can't Update Board : " + board);
		}
		rttr.addAttribute("div", board.getDiv());
		rttr.addAttribute("page", p.getPage());
		rttr.addAttribute("amount", p.getAmount());
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/remove")
	@Transactional
	public String remove(@RequestParam("bno")int bno, @ModelAttribute("p") Pager p, RedirectAttributes rttr) {
				
		rttr.addAttribute("div", service.get(bno).getDiv());
		rttr.addAttribute("page", p.getPage());
		rttr.addAttribute("amount", p.getAmount());
		
		if(service.remove(bno)) {
			log.info("========================================");
			log.info("@Board Controller, REMOVE BNO : " + bno);
			log.info("========================================");

			map_service.remove(bno);
			
			//�ش� �Խù��� �ִ� ��۵� ����
			List<ReplyVO> replies = reply_service.list(bno);
			replies.forEach(reply -> reply_service.remove(reply.getBno()));
			
			//�ش� �Խù��� �ִ� ���ϵ� ����
			List<FileVO> list = upload_service.getFileList(bno);
			log.info("Remove Board's Files : " + list);
			list.forEach(vo -> upload_service.deleteFile(vo.getUuid()));
		}
		else
			log.warn("Can't Remove Board Bno : " + bno);
		

		
		return "redirect:/board/list";
	}
	
	/*
	@GetMapping(value="/download")
	public void download(@RequestHeader("User-Agent") String agent, HttpServletResponse response, String uuid) throws UnsupportedEncodingException {
		
		FileVO file = upload_service.getFile(uuid);
		
		String fileName = file.getFileName();
		String path = "C:\\upload\\" + file.getPath() + "\\";
		String downloadPath = path + file.getUuid() + "_" + file.getFileName();
		
		String downloadFileName = "";
		
		File saveFile = new File(downloadPath);
		
		if(agent.contains("Trident")) {
			downloadFileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\", " ");
			log.info("IE Browser, File Name : " + downloadFileName);
		}
		else if(agent.contains("Edge")) {
			downloadFileName = URLEncoder.encode(fileName, "UTF-8");
			log.info("Edge Browser, File Name : " + downloadFileName);
		}
		else {
			downloadFileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
			log.info("Chrome Browser, File Name : " + downloadFileName);
		}
		
		response.setHeader("Content-Type", "application/octet-stream");
		response.setHeader("Content-Disposition", "attachment; filename=" + downloadFileName);
		
		int length;
		byte[] buffer = new byte[1024];
		
		try {
			InputStream is = new FileInputStream(saveFile);
			OutputStream os = response.getOutputStream();
			
			while((length = is.read(buffer)) != -1) {
				os.write(buffer, 0, length);
			}
			os.flush();
			os.close();
			is.close();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	*/

	@PostMapping(value = "/deleteFile")
	public String deleteFile(String uuid, int bno, RedirectAttributes rttr) throws UnsupportedEncodingException {
		
		FileVO vo = upload_service.getFile(uuid);
		String path = "C:\\upload\\" + vo.getPath() + "\\";
		String fileName = uuid + "_" + vo.getFileName();
		
		File file = new File(path + fileName);
		
		log.info(file.getAbsolutePath());
		if(file.delete()) {
			upload_service.deleteFile(uuid);
			rttr.addAttribute("msg", "file was deleted");
			log.info("Delete File UUID : " + uuid + " File Name : " + vo.getFileName());
		}
		else 
			log.info("Can't Delete File UUID : " + uuid + " File Name : " + vo.getFileName());
		
		return "redirect:/board/update?bno=" + bno;
	}
	
	@GetMapping(value="/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody //����->Ŭ���̾�Ʈ�� ������ ������ �� Body�� ������ ��ƺ���
	public ResponseEntity<Resource> download(@RequestHeader("User-Agent") String agent, String uuid) {
		
		FileVO file = upload_service.getFile(uuid);
		String path = "C:\\upload\\" + file.getPath() + "\\";
		
		Resource resource = new FileSystemResource(path + uuid + "_" + file.getFileName());
		
		if(!resource.exists())
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		
		log.info("Resource : " + resource);
		
		String resourceFileName = resource.getFilename();
		String originalFileName = resourceFileName;
		String downloadFileName = "";
		
		if(resourceFileName.contains("_"))
			originalFileName = resourceFileName.substring(resourceFileName.lastIndexOf("_") + 1);
		
		log.info("Original File Name : " + originalFileName);
		
		try {
			if(agent.contains("IE") || agent.contains("Trident")) {
				downloadFileName = URLEncoder.encode(downloadFileName, "UTF-8").replaceAll("\\", " ");
				log.info("IE Browser , downloadName = " + downloadFileName);
			}
			else if(agent.contains("Edge")) {
				
				downloadFileName = URLEncoder.encode(downloadFileName, "UTF-8");
				log.info("Edge Browser , downloadName = " + downloadFileName);
			}
			else {
				downloadFileName = new String(originalFileName.getBytes("UTF-8"), "ISO-8859-1");
				log.info("Chrome Browser , downloadName = " + downloadFileName);
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		HttpHeaders header = new HttpHeaders();
		
		header.add("Content-Disposition", "attachment; filename=" + downloadFileName);
		
		return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
	}
	
	
	/* ======================================================= */
	
	public void fileUpload(MultipartFile[] uploadFile, int bno) {
		
		String path = "C:\\upload";
		String uploadFolderPath = getFolder();
		
		File uploadPath = new File(path, uploadFolderPath);
		
		List<FileVO> list = new ArrayList<FileVO>(); 
		
		log.info("==========================");
		log.info("@Controller, UploadController");
		log.info("Upload Path : " + uploadPath.toString());
		
		//������ ���ٸ� ���� ����
		if(!uploadPath.exists())
			uploadPath.mkdirs();

		for(MultipartFile file : uploadFile) {
			log.info("File Name : " + file.getOriginalFilename());
			log.info("File Size : " + file.getSize());
			
			//MultipartFile -> File (���� ���� ����)
			FileVO vo = new FileVO();
			
			UUID uuid = UUID.randomUUID(); //�ߺ������� ���� UUID
			String fileName = file.getOriginalFilename();
			fileName = fileName.substring(fileName.lastIndexOf("\\") + 1); //IE���� ���ε� �� ���� ����
			
			vo.setFileName(fileName);
			vo.setUuid(uuid.toString());
			vo.setPath(uploadFolderPath);
			//vo.setBno(bno);
			
			fileName = uuid + "_" + fileName;
			
			File saveFile = new File(uploadPath, fileName);
			
			try {
				file.transferTo(saveFile);
				
				if(checkImageType(saveFile)) vo.setFileType('i');
				else vo.setFileType('f');
				
				list.add(vo);
					
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		} //for(MultipartFile file : uploadFile)
		if(bno == 0)
			upload_service.fileUpload(list);
		else
			upload_service.fileUpdate(list, bno);
	}
	
	public String getFolder() {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	public boolean checkImageType(File file) {
		
		String contentType;
		try {
			contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
}
