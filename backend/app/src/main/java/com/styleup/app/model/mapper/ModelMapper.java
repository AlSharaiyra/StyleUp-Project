package com.styleup.app.model.mapper;

import com.styleup.app.model.FeaturesModel;
import com.styleup.app.model.ItemModel;
import com.styleup.app.model.UserModel;
import com.styleup.app.model.response.ItemResponse;
import com.styleup.app.repository.entity.Item;
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
    public UserModel toUserModel(final User user){

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

    /**
     * A method that converts an Item entity to an item model.
     *
     * @param item the item entity
     * @return ItemModel the item representation
     */
    public ItemModel toItemModel(final Item item) {

        ItemModel itemModel = new ItemModel();

        itemModel.setId(item.getId());
        itemModel.setDescription(item.getDescription());
        itemModel.setObjectKey(item.getObjectKey());
        itemModel.setGender(item.getGender());
        itemModel.setMasterCategory(item.getMasterCategory());
        itemModel.setSubCategory(item.getSubCategory());
        itemModel.setArticleType(item.getArticleType());
        itemModel.setBaseColour(item.getBaseColour());
        itemModel.setSeason(item.getSeason());
        itemModel.setUsage(item.getUsage());

        return itemModel;
    }

    /**
     * A method that converts an Item entity to an item model.
     *
     * @param item the item entity
     * @return ItemModel the item representation
     */
    public ItemResponse toItemResponse(final Item item, final String url) {

        ItemResponse itemResponse = new ItemResponse();

        itemResponse.setItemId(item.getId());
        itemResponse.setDescription(item.getDescription());
        itemResponse.setUrl(url);

        return itemResponse;
    }

    public Item populateItemFromFeaturesModel(final FeaturesModel features) {

        Item item = new Item();

        // Setting features
        item.setGender(features.getGender());
        item.setMasterCategory(features.getMasterCategory());
        item.setSubCategory(features.getSubCategory().toLowerCase());
        item.setArticleType(features.getArticleType());
        item.setBaseColour(features.getBaseColour().toLowerCase());
        item.setSeason(features.getSeason().toLowerCase());
        item.setUsage(features.getUsage().toLowerCase());

        return item;
    }
}
