package org.juyb99.pickmecupspring.service;

import org.juyb99.pickmecupspring.dto.request.GameItemRequestDTO;
import org.juyb99.pickmecupspring.dto.response.GameItemResponseDTO;
import org.juyb99.pickmecupspring.repository.GameItemRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class GameItemService {
    private final GameItemRepository gameItemRepository;

    public GameItemService(GameItemRepository gameItemRepository) {
        this.gameItemRepository = gameItemRepository;
    }

    public List<GameItemResponseDTO> readAllGameItem() {
        return gameItemRepository.findAll();
    }

    public List<GameItemResponseDTO> readGameItemByTheme(String theme) {
        return gameItemRepository.findByTheme(theme);
    }

    public List<GameItemResponseDTO> readGameItemByTitle(String title) {
        return gameItemRepository.findByTitle(title);
    }

    public List<GameItemResponseDTO> saveItem(List<GameItemRequestDTO> gameItemRequestDTO) {
        return gameItemRequestDTO.stream()
                .map(gameItemRepository::save)
                .collect(Collectors.toList());
    }

    public void updateTotalWinsById(long id) {
        gameItemRepository.updateTotalWinsById(id);
    }
}
