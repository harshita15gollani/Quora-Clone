package com.example.QuinstionPost.service;

import com.example.QuinstionPost.Dto.CommentDto;
import com.example.QuinstionPost.Dto.ReturnAnswerCommentDto;
import com.example.QuinstionPost.Dto.TempCommentDto;

import java.util.List;

public interface CommentService {
    CommentDto addComment (CommentDto commentDto, String accountId);
    List<CommentDto> viewCommentsById(String answerId);
    ReturnAnswerCommentDto commentsLoader(String answerId);
}
