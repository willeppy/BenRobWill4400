package main.java.view;

import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.layout.BorderPane;
import main.java.model.CurrentState;

/**
 * Created by wepperson on 7/18/17.
 */
public class CategoryView {

    private static String fxml = "CategoryPage.fxml";
    private static BorderPane instance;

    public static BorderPane getInstance() {
        instance = (BorderPane) FXBuilder.getFXMLView(fxml);
        return instance;
    }

    @FXML
    Button addCategory, back;

    @FXML
    public void initialize() {
        back.setOnAction((event -> {
            RootView.instance.setCenter(FXBuilder.getFXMLView(CurrentState.pop()));
        }));

        addCategory.setOnAction((event -> {
            CurrentState.push(fxml);
            RootView.instance.setCenter(CategoryEditView.getInstance());

        }));
    }
}
