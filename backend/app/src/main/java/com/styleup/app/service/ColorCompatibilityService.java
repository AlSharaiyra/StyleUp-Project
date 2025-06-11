package com.styleup.app.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.styleup.app.model.ColorCompatibility;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Log4j2
@Service
@RequiredArgsConstructor
public class ColorCompatibilityService {

    private final Map<String, List<String>> compatibilityMap;

    public ColorCompatibilityService() {

        ObjectMapper mapper = new ObjectMapper();

        try (InputStream is = getClass().getClassLoader().getResourceAsStream("assets/colors.json")) {

            if (is == null) {
                throw new FileNotFoundException("colors.json not found in resources");
            }

            TypeReference<List<ColorCompatibility>> typeRef = new TypeReference<>() {};
            List<ColorCompatibility> colorList = mapper.readValue(is, typeRef);

            // Store only names in a map: "Blue" -> [ "Orange", "Navy Blue", ... ]
            this.compatibilityMap = colorList.stream()
                    .collect(Collectors.toMap(
                            c -> c.getName().toLowerCase(),
                            ColorCompatibility::getCompatible
                    ));
        } catch (IOException e) {
            log.error("Failed to load color compatibility data", e);
            throw new IllegalStateException("Color compatibility data couldn't be loaded.");
        }
    }

    public List<String> getCompatibleColors(String baseColorName) {
        return compatibilityMap.getOrDefault(baseColorName.toLowerCase(), List.of());
    }
}
