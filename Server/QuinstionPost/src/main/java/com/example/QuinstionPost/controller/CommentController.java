package com.example.QuinstionPost.controller;


import com.example.QuinstionPost.Dto.CommentDto;
import com.example.QuinstionPost.Dto.ReturnAnswerCommentDto;
import com.example.QuinstionPost.Dto.TempCommentDto;
import com.example.QuinstionPost.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin("*")
@RestController
@RequestMapping("/comment")
public class CommentController {

    @Autowired
    CommentService commentService;

    @PostMapping(value = "/addComment/{accountId}")
    CommentDto addComment (@RequestBody CommentDto comment, @PathVariable("accountId") String accountId) {
        return commentService.addComment(comment, accountId);
    }

    @GetMapping(value = "viewCommentByAnswerId/{answerId}")
    List<CommentDto> viewCommentsById(@PathVariable("answerId") String answerId){
        return commentService.viewCommentsById(answerId);
        }


    @GetMapping(value = "viewNestedComments/{answerId}")
    ReturnAnswerCommentDto viewNestedComments(@PathVariable("answerId") String answerId){
        return commentService.commentsLoader(answerId);
    }
}

