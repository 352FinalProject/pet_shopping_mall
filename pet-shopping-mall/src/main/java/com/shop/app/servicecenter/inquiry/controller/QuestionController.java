package com.shop.app.servicecenter.inquiry.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.shop.app.common.HelloSpringUtils;
import com.shop.app.common.entity.imageAttachment;
import com.shop.app.member.entity.Member;
import com.shop.app.member.entity.MemberRole;
import com.shop.app.member.entity.Subscribe;
import com.shop.app.servicecenter.inquiry.dto.AnswerCreateDto;
import com.shop.app.servicecenter.inquiry.dto.QuestionCreateDto;
import com.shop.app.servicecenter.inquiry.dto.QuestionUpdateDto;
import com.shop.app.servicecenter.inquiry.entity.Answer;
import com.shop.app.servicecenter.inquiry.entity.Question;
import com.shop.app.servicecenter.inquiry.entity.QuestionDetails;
import com.shop.app.servicecenter.inquiry.service.QuestionService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/servicecenter")
@Controller
public class QuestionController {

	@Autowired
	private QuestionService questionService;
	
	// 고객센터 (선모)
	@GetMapping("/service.do")
	public void serviceCenter() {
		
	}
	
	// 1:1 목록 조회 + 페이징바 (예라)
	@GetMapping("/inquiry/questionList.do")
	public void questionList(@RequestParam(defaultValue = "1") int page, Question question, Model model) {
		int limit = 5;
		
		Map<String, Object> params = Map.of(
				"page", page,
				"limit", limit
			);
		
		int totalCount = questionService.findTotalQuestionCount();
		int totalPages = (int) Math.ceil((double) totalCount / limit);
		model.addAttribute("totalPages", totalPages);
		
		List<Question> questions = questionService.findQuestionAll(params);
		model.addAttribute("questions", questions);
	}
	
	// 1:1 목록 상세 조회 + 답변 (예라)
	@GetMapping("/inquiry/questionDetail.do")
	public void questionDetail(Question question, Model model) {
	    
		// 1:1 상세 조회

	    Question questions = questionService.findQuestionByAnwerCount(question);
	    log.debug("questions = {}", questions);
	    model.addAttribute("questions", questions);
	    
	    int questionId = question.getQuestionId();
	    
	    // 1:1 답변 조회
	    Answer answer = Answer
	    		.builder()
	    		.answerQuestionId(questionId)
	    		.build();

	    Answer answers = questionService.findQuestionAnswersById(answer);
	    model.addAttribute("answers", answers);
	    
	    // 이미지 파일 정보 조회
	    QuestionDetails questionDetails = questionService.findImageAttachmentsByQuestionId(questionId);
	    log.debug("questionDetails = {}", questionDetails);
	    model.addAttribute("questionDetails", questionDetails);
}
	
	// 1:1 문의 작성 연결 + 조회 (예라)
	@GetMapping("/inquiry/questionCreate.do")
	public void qreateCuestion(Question question, Model model) {

		Question questions = questionService.findQuestionById(question);
	    model.addAttribute("questions", questions);
	}
	
	// 1:1 문의 작성 (예라)
	@PostMapping("/inquiry/questionCreate.do")
	public String questionCreate(QuestionCreateDto _question, 
			@RequestParam(value = "upFile", required = false) List<MultipartFile> upFiles) 
					throws IllegalStateException, IOException {
		
		// 1. 파일 저장
		List<imageAttachment> attachments = new ArrayList<>();
		for(MultipartFile upFile : upFiles) {			
		    if(!upFile.isEmpty()) {
		        String imageOriginalFilename = upFile.getOriginalFilename();
		        String imageRenamedFilename = HelloSpringUtils.getRenameFilename(imageOriginalFilename); 
		        File destFile = new File(imageRenamedFilename); 
		        upFile.transferTo(destFile);	

		        int imageType = 1; 

		        imageAttachment attach = 
		            imageAttachment.builder()
		            .imageOriginalFilename(imageOriginalFilename)
		            .imageRenamedFilename(imageRenamedFilename)
		            .imageType(imageType)
		            .imageFileSize(upFile.getSize())
		            .build();

		        attachments.add(attach);
		    }
		}
		
		// 2. db 저장
		QuestionDetails questions = QuestionDetails.builder()
				.questionMemberId(_question.getQuestionMemberId())
				.questionTitle(_question.getQuestionTitle())
				.questionContent(_question.getQuestionContent())
				.questionCategory(_question.getQuestionCategory())
				.questionEmail(_question.getQuestionEmail())
				.attachments(attachments)
				.build();
		
		// 질문을 먼저 db에 저장
		int questionId = questionService.insertQuestion(questions);
		
		return "redirect:/servicecenter/inquiry/questionList.do";
	}
	
	// 1:1 문의 삭제 (예라)
	@PostMapping("/inquiry/DeleteQuestion.do")
	public String questionDelete(@RequestParam int questionId) {
		
		int result = questionService.deleteQuestion(questionId);
		
		return "redirect:/servicecenter/inquiry/questionList.do";
	}
	
	// 1:1 문의 수정 연결 + 조회 (예라)
	@GetMapping("/inquiry/questionUpdate.do")
	public void questionUpdate(@RequestParam int questionId, Model model) {

		Question question = Question
				.builder()
				.questionId(questionId)
				.build();

	    Question questions = questionService.findQuestionById(question);
	    model.addAttribute("questions", questions);
	}
	
	// 1:1 문의 수정 (예라)
	@PostMapping("/inquiry/questionUpdate.do")
	public String updateQuestion(QuestionUpdateDto _question) {
		
		Question questions = _question.toQuestion();
		int result = questionService.updateQuestion(questions);
		
		return "redirect:/servicecenter/inquiry/questionDetail.do?questionId=" + questions.getQuestionId();
	}
	
	// 1:1 문의 실시간 검색 (예라)
	@GetMapping("/inquiry/questionSearch.do")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> questionSearch(
	        @RequestParam(required = false) String searchKeyword, Model model, Question question) {
	    Map<String, Object> result = new HashMap<>();
	    
	    if (searchKeyword != null && !searchKeyword.isEmpty()) {
	        List<Question> questions = questionService.questionSearch(searchKeyword);
	        
	        // 각 질문의 답변 수 계산하여 추가
	        for (Question q : questions) {
	            int answerCount = questionService.calculateAnswerCount(q.getQuestionId());
	            log.debug("answerCount = {}", answerCount);
	            q.setAnswerCount(answerCount);
	        }
	        
	        model.addAttribute("questions", questions);
	        result.put("questions", questions);
	        return new ResponseEntity<>(result, HttpStatus.OK);
	        
	    }
	    return new ResponseEntity<>(result, HttpStatus.BAD_REQUEST);
	}

}