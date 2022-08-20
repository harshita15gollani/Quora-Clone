package com.example.QuinstionProfile.repository;

import com.example.QuinstionProfile.entity.Account;
import com.example.QuinstionProfile.entity.FollowersAndFollowing;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.data.mongodb.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AccountRepository extends MongoRepository<Account, String> {
//    @Query("{accountId:?0}")
//    Optional<Account> findByAccountId(String id);
}
