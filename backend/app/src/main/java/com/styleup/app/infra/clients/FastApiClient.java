package com.styleup.app.infra.clients;

import com.styleup.app.model.FeaturesModel;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

@Service
public class FastApiClient {

    @Value("${app.fast-api.key}")
    private String fastApiKey;

    private final RestTemplate restTemplate = new RestTemplate();

    public FeaturesModel sendFileToFastApi(byte[] fileBytes) {
        String url = "http://localhost:8000/predict/file";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.MULTIPART_FORM_DATA);
        headers.set("req-api-key", fastApiKey);

        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        ByteArrayResource fileAsResource = new ByteArrayResource(fileBytes) {
            @Override
            public String getFilename() {
                return "image.jpg";  // or actual filename
            }
        };

        body.add("file", fileAsResource);

        HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<>(body, headers);

        ResponseEntity<FeaturesModel> response = restTemplate.postForEntity(url, requestEntity, FeaturesModel.class);

        return response.getBody();
    }
}
