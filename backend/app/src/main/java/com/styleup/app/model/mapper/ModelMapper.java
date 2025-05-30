package com.styleup.app.model.mapper;

import com.styleup.app.model.UserModel;
import com.styleup.app.repository.entity.User;
import org.springframework.stereotype.Component;

/**
 * A mapper class that converts between user entities and models.
 *
 * @author Walid Sharaiyra
 * @since 05/2025
 * @version 1.0
 */
@Component
public class ModelMapper {

    /**
     * A method that converts a user entity to a user model.
     *
     * @param user the user entity
     * @return UserModel the user representation
     */
    public UserModel toUserModel(User user){

        UserModel userModel = new UserModel();

        userModel.setUserId(user.getId());
        userModel.setFullName(user.getFullName());
        userModel.setEmail(user.getEmail());
        userModel.setAge(user.getAge());
        userModel.setGender(user.getGender());
        userModel.setCreatedAt(user.getCreatedAt());
        userModel.setLastUpdated(user.getLastUpdated());
        userModel.setLastLogin(user.getLastLogin());
        userModel.setStatus(user.getStatus());

        return userModel;
    }
}
