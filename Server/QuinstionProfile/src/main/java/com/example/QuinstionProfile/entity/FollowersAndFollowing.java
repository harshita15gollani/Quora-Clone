package com.example.QuinstionProfile.entity;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Getter
@Setter
@ToString
@Document(collection = "FollowersAndFollowing")
public class FollowersAndFollowing {
    @Id
    String id;
    String accountId;
    List<String> followers;
    List<String> following;
    List<String> followRequests;

    public void setFollowers(List<String> followers) {
        this.followers = followers;
    }

    public void setFollowing(List<String> following) {
        this.following = following;
    }

    public void setFollowRequests(List<String> followRequests) {
        this.followRequests = followRequests;
    }
}
