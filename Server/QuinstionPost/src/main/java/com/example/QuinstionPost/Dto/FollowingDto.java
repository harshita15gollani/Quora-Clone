package com.example.QuinstionPost.Dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Getter
@Setter
@ToString
public class FollowingDto {
    String accountId;
    List<String> following;

    public void setFollowing(List<String> following) {
        this.following = following;
    }

    public List<String> getFollowing() {
        return following;
    }
}
