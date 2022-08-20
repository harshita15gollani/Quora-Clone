package com.example.QuinstionPost.service.impl;

import com.example.QuinstionPost.Dto.AccountDto;
import com.example.QuinstionPost.Dto.CommentDto;
import com.example.QuinstionPost.Dto.ReturnAnswerCommentDto;
import com.example.QuinstionPost.Dto.TempCommentDto;
import com.example.QuinstionPost.entity.Answer;
import com.example.QuinstionPost.entity.Comment;
import com.example.QuinstionPost.repository.AnswerRepository;
import com.example.QuinstionPost.repository.CommentRepository;
import com.example.QuinstionPost.service.CommentService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    CommentRepository commentRepository;

    @Autowired
    AnswerRepository answerRepository;

    @Override
    public CommentDto addComment(CommentDto commentDto, String accountId) {

        // todo : move this to async process
        RestTemplate restTemplate = new RestTemplate();
        String resourceUrl = "http://localhost:8080/account/viewAccount/" + accountId;
        ResponseEntity<AccountDto> responseEntity = restTemplate.getForEntity(resourceUrl, AccountDto.class);
//        System.out.println(responseEntity);


        Comment commentToBePosted = new Comment();
        BeanUtils.copyProperties(commentDto, commentToBePosted);
//        Optional<Comment> Parent = commentRepository.findById(commentDto.getParentId());
//        commentToBePosted.setLevel(Parent.get().getLevel()+1);
        commentToBePosted.setUserName(responseEntity.getBody().getUserName());
        commentToBePosted.setProfileImage(responseEntity.getBody().getProfileImage());
        commentToBePosted.setAccountId(accountId);

        commentRepository.save(commentToBePosted);
        return commentDto;
    }

    @Override
    public List<CommentDto> viewCommentsById(String answerId) {
        List<Comment> comments = commentRepository.findByAnswerId(answerId);
        if (!comments.isEmpty()) {
            List<CommentDto> commentDto = new ArrayList<>();
            BeanUtils.copyProperties(comments, commentDto);
//            System.out.println(comments);
            return commentDto;
        } else {
            System.out.println("comments in empty");
            return null;
        }
    }


    @Override
    public ReturnAnswerCommentDto commentsLoader(String answerId) {
        Optional<Answer> answer = answerRepository.findById(answerId);
        ReturnAnswerCommentDto temp = new ReturnAnswerCommentDto();
        if (answer.isPresent()) {
            BeanUtils.copyProperties(answer.get(),temp);
            List<TempCommentDto> nested = new ArrayList<>();

            List<Comment> level0 = commentRepository.findByAnswerIdAndLevel(answerId, 0);

            for (Comment c : level0) {
                TempCommentDto temp0 = new TempCommentDto();
                BeanUtils.copyProperties(c, temp0);
                List<TempCommentDto> tempList0 = new ArrayList<>();
                List<Comment> level1 = commentRepository.findByParentId(c.getId());
                for (Comment c1 : level1) {
                    TempCommentDto temp1 = new TempCommentDto();
                    BeanUtils.copyProperties(c1, temp1);
                    List<TempCommentDto> tempList1 = new ArrayList<>();
                    List<Comment> level2 = commentRepository.findByParentId(c1.getId());
                    for (Comment c2 : level2) {
                        TempCommentDto temp2 = new TempCommentDto();
                        BeanUtils.copyProperties(c2, temp2);
                        List<TempCommentDto> tempList2 = new ArrayList<>();
                        List<Comment> level3 = commentRepository.findByParentId(c2.getId());
                        for (Comment c3 : level3) {
                            TempCommentDto temp3 = new TempCommentDto();
                            BeanUtils.copyProperties(c3, temp3);
                            List<Comment> level4 = commentRepository.findByParentId(c3.getId());
                            List<TempCommentDto> tempList3 = new ArrayList<>();
                            for (Comment c4 : level4) {
                                TempCommentDto temp4 = new TempCommentDto();
                                BeanUtils.copyProperties(c4, temp4);
                                temp4.setNestedComment(new ArrayList<>());
                                tempList3.add(temp4);
                            }
                            temp3.setNestedComment(tempList3);
                            tempList2.add(temp3);
                        }
                        temp2.setNestedComment(tempList2);
                        tempList1.add(temp2);
                    }
                    temp1.setNestedComment(tempList1);
                    System.out.println("temp0" + tempList1);
                    System.out.println("temp1" + temp1);
                    tempList0.add(temp1);
                }
                temp0.setNestedComment(tempList0);
                nested.add(temp0);
            }
            temp.setNestedComment(nested);
            System.out.println(nested);
            return temp;
        }
        return null;
    }
}
