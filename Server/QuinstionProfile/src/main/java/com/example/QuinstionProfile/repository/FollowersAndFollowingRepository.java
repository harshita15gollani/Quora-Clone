package com.example.QuinstionProfile.repository;

import com.example.QuinstionProfile.entity.FollowersAndFollowing;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;

import java.util.Optional;

public interface FollowersAndFollowingRepository extends MongoRepository<FollowersAndFollowing, String> {
    @Query("{accountId:?0}")
    Optional<FollowersAndFollowing> findByAccountId(String id);

}
