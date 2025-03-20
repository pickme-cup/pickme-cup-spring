package org.juyb99.pickmecupspring.controller.api;

import jakarta.servlet.ServletException;
import lombok.extern.slf4j.Slf4j;
import org.juyb99.pickmecupspring.common.Exception.APIException;
import org.juyb99.pickmecupspring.dto.request.GameItemRequestDTO;
import org.juyb99.pickmecupspring.dto.response.GameItemResponseDTO;
import org.juyb99.pickmecupspring.service.GameItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.List;

@Slf4j
@RestController
@RequestMapping("/api/items")
public class GameItemController {
    private final GameItemService gameItemService;

    @Autowired
    public GameItemController(GameItemService gameItemService) {
        this.gameItemService = gameItemService;
    }

    @GetMapping("/")
    public ResponseEntity<List<GameItemResponseDTO>> getAll() {
        return new ResponseEntity<>(gameItemService.readAllGameItem(), HttpStatus.OK);
    }

    @GetMapping("/title/{title}")
    public ResponseEntity<List<GameItemResponseDTO>> getAllGameItemsByTitle(@PathVariable(name = "title") String title) {
        return new ResponseEntity<>(gameItemService.readGameItemByTheme(title), HttpStatus.OK);
    }

    @GetMapping("/theme/{theme}")
    public ResponseEntity<List<GameItemResponseDTO>> getAllGameItemsByTheme(@PathVariable(name = "theme") String theme) {
        return new ResponseEntity<>(gameItemService.readGameItemByTheme(theme), HttpStatus.OK);
    }

    @PostMapping
    public ResponseEntity<List<GameItemResponseDTO>> createGameItem(@RequestBody List<GameItemRequestDTO> gameItemRequestDTOList) throws ServletException, IOException {
        try {
            return new ResponseEntity<>(gameItemService.saveItem(gameItemRequestDTOList), HttpStatus.OK);
        } catch (APIException e) {
            log.info(e.getMessage());
            return new ResponseEntity<>(e.getStatusCode());
        } catch (Exception e) {
            log.info(e.getMessage());
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @PutMapping("/title/{itemId}")
    protected void updateTotalWins(@PathVariable("itemId") long id) throws ServletException, IOException {
        log.info("updateTotalWins: id = {}", id);
        gameItemService.updateTotalWinsById(id);
    }
}
