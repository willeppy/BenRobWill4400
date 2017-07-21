package main.java.view;

import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.scene.control.TextInputDialog;
import javafx.scene.layout.BorderPane;
import main.java.controller.ManagerController;
import main.java.controller.UserController;
import main.java.model.CurrentState;

import java.util.Optional;

/**
 * Created by Rob on 7/18/2017.
 */
public class ManagerView {
    // TODO: update other views to have private instance

    private static String fxml = "ManagerPage.fxml";
    private static BorderPane instance;

    public static BorderPane getInstance() {
        instance = (BorderPane) FXBuilder.getFXMLView(fxml);
        return instance;
    }

    @FXML
    private Button logOut, viewAllCities, viewAllAttractions, viewAllCategories, viewAllUsers, viewPendingCities,
        viewPendingAttractions, addNewCity, addNewUser, addNewAttraction, addNewCategory, search, searchAllAttractions;

    @FXML
    private Label welcomeMessage, searchFail;

    @FXML
    private ComboBox<String> cities, categories, sort;

    @FXML
    public void initialize() {
        cities.setItems(ManagerController.cityNamesList(""));
        categories.setItems(ManagerController.categoriesList(""));

        welcomeMessage.setText("Welcome " + CurrentState.getEmail() + "!");

        search.setOnAction(event -> {
            search();
        });

        sort.setItems(FXCollections.observableArrayList("A -> Z", "Z -> A"));
        sort.valueProperty().addListener((observable, oldValue, newValue) -> {
            cities.setItems(ManagerController.cityNamesList(newValue));
            categories.setItems(ManagerController.categoriesList(newValue));
        });

        logOut.setOnAction((event -> {
            CurrentState.push(fxml);
            RootView.instance.setCenter(LoginView.getInstance());

         }));

        viewAllCities.setOnAction((event -> {
            CurrentState.push(fxml);
            RootView.instance.setCenter(AllCitiesView.getInstance());

        }));

        viewAllAttractions.setOnAction((event -> {
            CurrentState.push(fxml);
            RootView.instance.setCenter(AllAttractionListView.getInstance());

        }));

        viewAllCategories.setOnAction((event -> {
            CurrentState.push(fxml);
            RootView.instance.setCenter(CategoryView.getInstance());

        }));

        viewAllUsers.setOnAction((event -> {
            CurrentState.push(fxml);
            RootView.instance.setCenter(AllUsersListView.getInstance());

        }));

        viewPendingCities.setOnAction((event -> {
            CurrentState.push(fxml);
            RootView.instance.setCenter(PendingCitiesListView.getInstance());

        }));

        viewPendingAttractions.setOnAction((event -> {
            CurrentState.push(fxml);
            RootView.instance.setCenter(PendingAttractionsView.getInstance());

        }));

        addNewCity.setOnAction((event -> {
            CurrentState.push(fxml);
            RootView.instance.setCenter(NewCityView.getInstance());

        }));

        addNewAttraction.setOnAction((event -> {
            CurrentState.push(fxml);
            RootView.instance.setCenter(NewAttractionView.getInstance());

        }));

        addNewUser.setOnAction((event -> {
            CurrentState.push(fxml);
            RootView.instance.setCenter(SignUpView.getInstance());

        }));


        addNewCategory.setOnAction((event -> {
            TextInputDialog newCategoryDialog = new TextInputDialog();
            newCategoryDialog.setTitle("New Category");
            newCategoryDialog.setHeaderText("What is the Name of the New Category?");
            newCategoryDialog.setContentText("Please Enter a Name:");

            Optional<String> newCategory = newCategoryDialog.showAndWait();
            //TODO: add newCategory to database
        }));
    }

    @FXML
    private void search() {
        searchFail.setText("");
        if (cities.getSelectionModel().isEmpty()) {
            searchFail.setText("Please select a city");
        }
        CurrentState.setCurrentCity(cities.getValue());
        if (!categories.getSelectionModel().isEmpty()) {
            CurrentState.setCurrentCategory(categories.getValue());
        }
        CurrentState.push(fxml);
        RootView.instance.setCenter(CityView.getInstance());
    }
}
