package main.java.view;

import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.layout.BorderPane;
import main.java.model.CurrentState;

/**
 * Created by wepperson on 7/18/17.
 */
public class CityAllReviewView {

    private static String fxml = "CityReviewPage.fxml";
    private static BorderPane instance = (BorderPane) FXBuilder.getFXMLView(fxml);

    public static BorderPane getInstance() {
        instance = (BorderPane) FXBuilder.getFXMLView(fxml);
        return instance;
    }

    @FXML
    Button reviewCity, back;

    @FXML
    public void initialize() {
        back.setOnAction((event -> {
            RootView.instance.setCenter(FXBuilder.getFXMLView(CurrentState.pop()));
        }));
    }
}
