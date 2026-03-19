package com.divyesh.prep.repository;

import com.divyesh.prep.model.User;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class UserRepository {

    private final JdbcTemplate jdbcTemplate;

    public UserRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    private final RowMapper<User> userRowMapper = (rs, rowNum) -> {
        User user = new User();
        user.setUuid(rs.getString("uuid"));
        user.setName(rs.getString("name"));
        user.setAge(rs.getInt("age"));
        return user;
    };

    public int addUser(User user) {
        String sql = "INSERT INTO users (uuid, name, age) VALUES (?, ?, ?)";
        return jdbcTemplate.update(sql, user.getUuid(), user.getName(), user.getAge());
    }

    public List<User> getUsers() {
        String sql = "SELECT * FROM users";
        return jdbcTemplate.query(sql, userRowMapper);
    }

    public User getUser(String uuid) {
        String sql = "SELECT * FROM users WHERE uuid=?";
        return jdbcTemplate.queryForObject(sql, userRowMapper, uuid);
    }
}
