package org.practice.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.practice.domain.BoardVO;
import org.practice.domain.FileVO;
import org.practice.mapper.UploadMapper;
import org.practice.service.BoardService;
import org.practice.service.ReplyService;
import org.practice.service.UploadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	
	
	@GetMapping("/list")
	public void list(int div, Model model) {
		
		log.info("=============== Board Controller ====================");
		model.addAttribute("list", service.getList(div));
		model.addAttribute("division", div);
	}
	
	@GetMapping("/write")
	public void write(int div, Model model) {
		
		log.info("# Board Write Page");
		model.addAttribute("division", div);
	}
	@PostMapping("/write")
	public String write(BoardVO board, @RequestParam(name="uploadFile") MultipartFile[] uploadFile, 
			RedirectAttributes rttr) {
		
		log.info("================================");
		log.info("@Controller - BoardVO : " + board);
		service.write(board);
		
		if(uploadFile[0].getSize() != 0) {
			fileUpload(uploadFile);
		}
		log.info("================================");
		
		rttr.addFlashAttribute("msg", "Write Success");
		
		return "redirect:/board/list?div=" + board.getDiv();
	}
	
	@GetMapping({"/get"})
	@Transactional
	public void get(int bno, Model model) {
		
		log.info("===============================");
		log.info("@Controller, Board Get Bno : " + bno);
		log.info("===============================");
		
		service.hit(bno);
		model.addAttribute("board", service.get(bno));
		model.addAttribute("file", upload_service.getFileList(bno));
		model.addAttribute("reply", reply_service.list(bno));
	}
	
	@GetMapping({"/update"})
	public void update(int bno, Model model) {
		
		log.info("===============================");
		log.info("@Controller, Board Update Bno : " + bno);
		log.info("===============================");
		
		model.addAttribute("board", service.get(bno));
		model.addAttribute("file", upload_service.getFileList(bno));
	}
	@PostMapping("/update")
	public String update(BoardVO board, RedirectAttributes rttr) {
		
		if(service.update(board)) {
			rttr.addAttribute("msg", "Update Success");
			log.info("Update Board : " + board);
		}
		else {
			rttr.addAttribute("msg", "Update Fail");
			log.info("Can't Update Board : " + board);
		}
		//file �������� ������ �����ؾ��� !!!!!!!!!!!
		
		return "redirect:/board/list?div=" + board.getDiv();
	}
	
	@GetMapping("/remove")
	public String remove(int bno, RedirectAttributes rttr) {
		
		int div = service.get(bno).getDiv();
		
		if(service.remove(bno))
			log.info("Remove Board Bno : " + bno);
		else
			log.warn("Can't Remove Board Bno : " + bno);
		
		return "redirect:/board/list?div=" + div;
	}
	
	
	/* ======================================================= */
	
	public void fileUpload(MultipartFile[] uploadFile) {
		
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
		
		upload_service.fileUpload(list);
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
