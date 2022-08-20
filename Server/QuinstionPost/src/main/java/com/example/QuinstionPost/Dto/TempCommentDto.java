package com.example.QuinstionPost.Dto;

import com.example.QuinstionPost.entity.Comment;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.ArrayList;
import java.util.List;

@Setter
@Getter
@ToString
public class TempCommentDto {
    String accountId;
    String parentId; //Internal
    String answerId;
    int level;
    String userName;
    String profileImage;
    String commentText;
    String codeEmbed;
    String urlEmbed;
    String id;
    List<TempCommentDto> nestedComment;

    public void setNestedComment(List<TempCommentDto> nestedComment) {
        this.nestedComment = nestedComment;
    }

    public List<TempCommentDto> getNestedComment() {
        return nestedComment;
    }
    //    List<List<List<List<List<Comment>>>>> nestedComments;
}
