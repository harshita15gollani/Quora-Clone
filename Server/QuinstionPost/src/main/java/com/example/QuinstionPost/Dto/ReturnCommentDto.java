package com.example.QuinstionPost.Dto;

import com.example.QuinstionPost.entity.Comment;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;
@Setter
@Getter
@ToString
public class ReturnCommentDto {
    String accountId;
    String parentId;
    String answerId;
    String commentId;
    int level;
    String commentText;
    String codeEmbed;
    String urlEmbed;
    String profileImage;
    String userName;
}
