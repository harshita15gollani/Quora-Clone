package com.example.QuinstionPost.service.impl;

import com.example.QuinstionPost.Dto.AccountDto;
import com.example.QuinstionPost.Dto.QuestionDto;
import com.example.QuinstionPost.entity.Question;
import com.example.QuinstionPost.repository.QuestionRepository;
import com.example.QuinstionPost.service.QuestionService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import javax.management.Query;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class QuestionServiceImpl implements QuestionService {


    @Autowired
    QuestionRepository questionRepository;

    @Autowired
    protected MongoTemplate mongoTemplate;

    @Override
    public QuestionDto addQuestion(QuestionDto questionDto, String accountId) {

        // todo : move to async thread
        RestTemplate restTemplate = new RestTemplate();
        String resourceUrl = "http://localhost:8080/account/viewAccount/"+accountId;
        ResponseEntity<AccountDto> responseEntity = restTemplate.getForEntity(resourceUrl, AccountDto.class);

        RestTemplate restTemplate1 = new RestTemplate();
        String resourceUrl2 = "http://localhost:8080/account/updateScore/"+accountId +"/"+10;
        restTemplate1.postForObject(resourceUrl2,null,Void.class);

        Question questionToBePosted = new Question();
        BeanUtils.copyProperties(questionDto,questionToBePosted);
        questionToBePosted.setAccountId(accountId);
        questionToBePosted.setUserName(responseEntity.getBody().getUserName());
        questionToBePosted.setProfileImage(responseEntity.getBody().getProfileImage());
        LocalDateTime localDate = LocalDateTime.now();
        questionToBePosted.setDateCreated(Date.from(localDate.atZone(ZoneId.systemDefault()).toInstant()));
        questionRepository.save(questionToBePosted);
        questionDto.setQuestionId(questionToBePosted.getId());




        return questionDto;
    }

    @Override
    public List<QuestionDto> viewAllQuestions() {
        List<Question> allQuestion = questionRepository.findAll();
        if (!allQuestion.isEmpty()) {
            List<QuestionDto> allQuestionDto = new ArrayList<>();
            for (Question question : allQuestion) {
                QuestionDto questionDto = new QuestionDto();
                BeanUtils.copyProperties(question, questionDto);
                allQuestionDto.add(questionDto);
            }
            return allQuestionDto;
        }
        else{
            System.out.println("allQuestion is empty");
            return null;
        }
    }

    @Override
    public List<QuestionDto> viewQuestionsByCategory(String category) {
        List<Question> allQuestion = questionRepository.findByCategory(category);
        if (!allQuestion.isEmpty()) {
            List<QuestionDto> allQuestionDto = new ArrayList<>();
            for (Question question : allQuestion) {
                QuestionDto questionDto = new QuestionDto();
                BeanUtils.copyProperties(question, questionDto);
                allQuestionDto.add(questionDto);
            }
            return allQuestionDto;
        }
        else{
            System.out.println("allQuestion is empty");
            return null;
        }
    }

    @Override
    public List<QuestionDto> viewQuestionsByAccount(String accountId) {
        List<Question> allQuestion = questionRepository.findByAccountId(accountId);
        if(!allQuestion.isEmpty()) {
            List<QuestionDto> allQuestionDto = new ArrayList<>();
            for (Question question : allQuestion) {
                QuestionDto questionDto = new QuestionDto();
                BeanUtils.copyProperties(question, questionDto);
                allQuestionDto.add(questionDto);
            }
            return allQuestionDto;
        }
        else {
            System.out.println("allQuestion is empty");
            return null;
        }
    }

    @Override
    public QuestionDto viewQuestionsById(String questionId) {
        Optional<Question> question = questionRepository.findById(questionId);
        if (question.isPresent()) {
            QuestionDto questionDto = new QuestionDto();
            BeanUtils.copyProperties(question, questionDto);
            return questionDto;
        }
        else{
            System.out.println("question is not present");
            return null;
        }
    }

    @Override
    public void upVote(String questionId) {
        // todo : move this to inplace update
        Optional<Question> question = questionRepository.findById(questionId);
        if (question.isPresent()) {
            question.get().setNumberOfUpvotes(question.get().getNumberOfUpvotes() + 1);
            questionRepository.save(question.get());

            RestTemplate restTemplate = new RestTemplate();
            String resourceUrl = "http://localhost:8080/account/updateScore/"+question.get().getAccountId() +"/"+1;
            restTemplate.postForObject(resourceUrl,null,Void.class);
        }
        else {
            System.out.println("question is not present");
        }
    }

    @Override
    public void downVote(String questionId) {
        // todo : move this to inplace update
        Optional<Question> question = questionRepository.findById(questionId);
        if (question.isPresent()) {
            question.get().setNumberOfDownvotes(question.get().getNumberOfDownvotes() + 1);
            questionRepository.save(question.get());

            RestTemplate restTemplate = new RestTemplate();
            String resourceUrl = "http://localhost:8080/account/updateScore/"+question.get().getAccountId() +"/"+-1;
            restTemplate.postForObject(resourceUrl,null,Void.class);
        }
        else {
            System.out.println("question is not present");
        }
    }
}
