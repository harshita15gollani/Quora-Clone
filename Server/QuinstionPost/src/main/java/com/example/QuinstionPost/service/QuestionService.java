package com.example.QuinstionPost.service;

import com.example.QuinstionPost.Dto.QuestionDto;
import com.example.QuinstionPost.entity.Question;
import org.springframework.web.bind.annotation.RequestHeader;

import java.util.List;

public interface QuestionService {
    QuestionDto addQuestion (QuestionDto questionDto, String accountId);
    List<QuestionDto> viewAllQuestions();
    List<QuestionDto> viewQuestionsByCategory(String category);
    List<QuestionDto> viewQuestionsByAccount(String accountId);
    QuestionDto viewQuestionsById(String questionId);
    void upVote(String questionId);
    void downVote(String questionId);
}
