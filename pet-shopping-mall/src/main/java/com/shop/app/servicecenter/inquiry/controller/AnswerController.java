package com.shop.app.servicecenter.inquiry.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.shop.app.common.HelloSpringUtils;
import com.shop.app.common.controller.advice.MailSender;
import com.shop.app.servicecenter.inquiry.dto.AnswerCreateDto;
import com.shop.app.servicecenter.inquiry.dto.AnswerUpdateDto;
import com.shop.app.servicecenter.inquiry.dto.QuestionCreateDto;
import com.shop.app.servicecenter.inquiry.dto.QuestionUpdateDto;
import com.shop.app.servicecenter.inquiry.entity.Answer;
import com.shop.app.servicecenter.inquiry.entity.AnswerDetails;
import com.shop.app.servicecenter.inquiry.entity.Question;
import com.shop.app.servicecenter.inquiry.entity.QuestionDetails;
import com.shop.app.servicecenter.inquiry.service.AnswerService;
import com.shop.app.servicecenter.inquiry.service.QuestionService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/servicecenter")
@Controller
public class AnswerController {

	@Autowired
	private AnswerService answerService;
	
	@Autowired
	private QuestionService questionService;
	
	@Autowired
	private MailSender mailSender;
	
	// 관리자 1:1 문의 댓글 작성 (예라)
	@PostMapping("/inquiry/answerCreate.do")
	public String adminAnswerCreate(@RequestParam int questionId, @RequestParam String questionEmail, AnswerCreateDto _answer) {
		
		// 관리자 답변 등록
		AnswerDetails answers = AnswerDetails.builder()
				.answerContent(_answer.getAnswerContent())
				.answerAdminName(_answer.getAnswerAdminName())
				.answerQuestionId(questionId)
				.build();
		
		int result = answerService.insertAnswer(answers);
		
	    if (result > 0) {
	        // 답변이 등록되면 이메일을 보낸다
	        mailSender.sendEmailOnAnswerRegistration(questionEmail, _answer.getAnswerContent(), questionId);
	        log.debug("questionEmail = {}", questionEmail);
	    }
		
		// questionId 객체 생성
		Question question = Question.builder().questionId(questionId).build();
		// questionId 조회
		Question questions = questionService.findQuestionById(question);
		
		return "redirect:/servicecenter/inquiry/questionDetail.do?questionId=" + questionId;
	}
	
	// 관리자 1:1 문의 댓글 삭제 (예라)
	@PostMapping("/inquiry/answerDelete.do")
	public String adminAnswerDelete(@RequestParam int answerId, @RequestParam int questionId) {
		
		int result = answerService.deleteAnswer(answerId);
		
		return "redirect:/servicecenter/inquiry/questionDetail.do?questionId=" + questionId;
	}
	
	// 관리자 1:1 문의 댓글 수정 (예라)
	@PostMapping("/inquiry/answerUpdate.do")
	public String adminAnswerUpdate(AnswerUpdateDto _answer, QuestionUpdateDto _question) {
		
		Answer answers = _answer.toAnswer();
		int result = answerService.updateAnswer(answers);
		
		Question questions = _question.toQuestion();
		return "redirect:/servicecenter/inquiry/questionDetail.do?questionId=" + questions.getQuestionId();
	}
}