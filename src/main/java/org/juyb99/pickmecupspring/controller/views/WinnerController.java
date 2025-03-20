package org.juyb99.pickmecupspring.controller.views;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/winner")
public class WinnerController {

    @GetMapping
    public String showWinnerPage(Model model) {
        return "winner";
    }
}
