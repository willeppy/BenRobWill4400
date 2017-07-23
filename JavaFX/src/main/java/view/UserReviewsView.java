package main.java.view;

import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.BorderPane;
import main.java.controller.AttractionAllReviewController;
import main.java.controller.UserReviewsPageController;
import main.java.model.Attraction;
import main.java.model.CurrentState;
import main.java.model.Review;

/**
 * Created by Rob on 7/18/2017.
 */
public class UserReviewsView {

    private static String fxml = "UserReviewsPage.fxml";
    private static BorderPane instance;

    public static BorderPane getInstance() {
        instance = (BorderPane) FXBuilder.getFXMLView(fxml);
        return instance;
    }

    @FXML
    Button back;

    @FXML
    private Label userID;

    @FXML
    private TableView<Review> table;

    @FXML
    private TableColumn<Review, String> nameCol, ratingCol, commentCol;

    @FXML
    public void initialize() {

        // set up labels
        userID.setText(CurrentState.getEmail() +"'s Reviews");

        back.setOnAction((event -> {
            RootView.instance.setCenter(FXBuilder.getFXMLView(CurrentState.pop()));
        }));

        updateTable();
    }

    private void updateTable() {

        nameCol.setCellValueFactory(
                new PropertyValueFactory<>("userEmail"));
        ratingCol.setCellValueFactory(
                new PropertyValueFactory<>("rating"));
        commentCol.setCellValueFactory(
                new PropertyValueFactory<>("comment"));

        table.setItems(UserReviewsPageController.buildData());
    }
}
