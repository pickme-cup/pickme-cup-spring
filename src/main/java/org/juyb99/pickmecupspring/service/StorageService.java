package org.juyb99.pickmecupspring.service;

import org.juyb99.pickmecupspring.common.Exception.APIException;
import org.juyb99.pickmecupspring.repository.StorageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

@Service
public class StorageService {
    private final StorageRepository storageRepository;

    @Autowired
    public StorageService(StorageRepository storageRepository) {
        this.storageRepository = storageRepository;
    }

    public String uploadImage(String fileName, byte[] imageBytes) {
        return storageRepository.uploadImage(fileName, imageBytes)
                .orElseThrow(() -> new APIException(HttpStatus.BAD_REQUEST, "Failed to upload image"));
    }
}
