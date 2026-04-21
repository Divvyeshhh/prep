package com.divyesh.prep.service;

import com.divyesh.prep.model.User;
import com.divyesh.prep.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService {

    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public List<User> getUsersByName(String name) {
        return userRepository.findByName(name);
    }

    public User upsertUser(User user) {
        return userRepository.save(user);
    }

    public User getUser(String uuid) {
        Optional<User> user = userRepository.findById(uuid);
        return user.orElseThrow(() -> new RuntimeException("No user with uuid: " + uuid));
    }

    public List<User> getUsers() {
        return userRepository.findAll();
    }
}
