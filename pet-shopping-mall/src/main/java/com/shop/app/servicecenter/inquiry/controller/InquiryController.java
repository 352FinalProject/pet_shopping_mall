package com.shop.app.servicecenter.inquiry.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.app.common.HelloSpringUtils;
import com.shop.app.common.entity.Attachment;
import com.shop.app.common.entity.IsDeleted;
import com.shop.app.common.entity.Thumbnail;
import com.shop.app.servicecenter.inquiry.dto.QuestionCreateDto;
import com.shop.app.servicecenter.inquiry.dto.QuestionUpdateDto;
import com.shop.app.servicecenter.inquiry.entity.Answer;
import com.shop.app.servicecenter.inquiry.entity.Question;
import com.shop.app.servicecenter.inquiry.entity.QuestionDetails;
import com.shop.app.servicecenter.inquiry.service.InquiryService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/servicecenter")
@Controller
public class InquiryController {

	@Autowired
	private InquiryService inquiryService;
	
	// 고객센터 (선모)
	@GetMapping("/service.do")
	public void serviceCenter() {
		
	}
	
	// 1:1 목록 조회 (예라)
	@GetMapping("/inquiry/questionList.do")
	public void questionList(Question question, @RequestParam String content, Model model) {
		List<Question> questions = inquiryService.findQuestionAll(question);
		model.addAttribute("questions", questions);
		
		Answer answers = inquiryService.findAnswersByContent(content);
		model.addAttribute("answers", answers);
		
	}
	
	// 1:1 목록 상세 조회 + 답변 (예라)
	@GetMapping("/inquiry/questionDetail.do")
	public void questionDetail(@RequestParam int questionId, Model model) {
	    
		// 1:1 상세 조회
		Question question = Question
				.builder()
				.id(questionId)
				.build();

	    Question questions = inquiryService.findQuestionById(question);
	    model.addAttribute("questions", questions);
	    
	    // 1:1 답변 조회
	    Answer answer = Answer
	    		.builder()
	    		.questionId(questionId)
	    		.build();

	    Answer answers = inquiryService.findQuestionAnswersById(answer);
	    model.addAttribute("answers", answers);
	}
	
	// 1:1 문의 작성 연결 + 조회 (예라)
	@GetMapping("/inquiry/questionCreate.do")
	public void CreateQuestion(Question question, Model model) {

		Question questions = inquiryService.findQuestionById(question);
	    model.addAttribute("questions", questions);
	}
	
	// 1:1 문의 작성 (예라)
	@PostMapping("/inquiry/questionCreate.do")
	public String CreateQuestion(QuestionCreateDto _question, 
			@RequestParam(value = "upFile", required = false) List<MultipartFile> upFiles) 
					throws IllegalStateException, IOException {
		
		// 1. 파일 저장
		List<Attachment> attachments = new ArrayList<>();
		for(MultipartFile upFile : upFiles) {			
		    if(!upFile.isEmpty()) {
		        String originalFilename = upFile.getOriginalFilename();
		        String renamedFilename = HelloSpringUtils.getRenameFilename(originalFilename); 
		        File destFile = new File(renamedFilename); 
		        upFile.transferTo(destFile);	

		        int imageType = 1; 

		        Attachment attach = 
		            Attachment.builder()
		            .originalFilename(originalFilename)
		            .renamedFilename(renamedFilename)
		            .imageType(imageType)
		            .thumbnail(Thumbnail.N) 
		            .fileSize(upFile.getSize())
		            .isDeleted(IsDeleted.N)
		            .build();

		        log.debug("attach = {}", attach);
		        attachments.add(attach);
		    }
		}	
		// 2. db 저장
		QuestionDetails questions = QuestionDetails.builder()
				.memberId(_question.getMemberId())
				.productId(_question.getProductId())
				.title(_question.getTitle())
				.content(_question.getContent())
				.attachments(attachments)
				.build();
		
		int result = inquiryService.insertQuestion(questions);
		
		return "redirect:/servicecenter/inquiry/questionList.do";
	}
	
	// 1:1 문의 삭제 (예라)
	@PostMapping("/inquiry/DeleteQuestion.do")
	public String DeleteQuestion(@RequestParam int id) {
		
		int result = inquiryService.deleteQuestion(id);
		
		return "redirect:/servicecenter/inquiry/questionList.do";
	}
	
	// 1:1 문의 수정 연결 + 조회 (예라)
	@GetMapping("/inquiry/questionUpdate.do")
	public void UpdateQuestion(Question question, Model model) {

		Question questions = inquiryService.findQuestionById(question);
	    model.addAttribute("questions", questions);
	}
	
	// 1:1 문의 수정 (예라)
	@PostMapping("/inquiry/questionUpdate.do")
	public String UpdateQuestion(QuestionUpdateDto _question) {
		
		Question questions = _question.toQuestion();
		int result = inquiryService.updateQuestion(questions);
		
		return "redirect:/servicecenter/inquiry/questionDetail.do?questionId=" + questions.getId();
	}
	
}
