package main.java.controller;



import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.scene.control.*;
import javafx.util.Callback;
import main.java.model.Category;
import main.java.model.City;
import main.java.sql.DBConnection;

import java.sql.ResultSet;
import java.sql.SQLException;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import main.java.model.City;
import main.java.model.CurrentState;
import main.java.sql.DBConnection;
import main.java.view.CategoryView;
import main.java.view.CityView;
import main.java.view.FXBuilder;
import main.java.view.RootView;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Optional;

/**
 * Created by Michael Xiao Local on 7/23/2017.
 */
public class CategoriesListController {

    public static ObservableList<Category> buildData() {
        ObservableList<Category> data = FXCollections.observableArrayList();
        String categoryQuery =
                "SELECT CName as Category, COUNT(*) AS NumAttractions\n" +
                        "\tFROM RateACity.CATEGORY \n" +
                        "    NATURAL JOIN RateACity.FALLS_UNDER\n" +
                        "    NATURAL JOIN RateACity.ATTRACTION\n" +
                        "\tGROUP BY Category\n" +
                        "    ;";

        try {
            ResultSet rs = DBConnection.connection.createStatement().executeQuery(categoryQuery);

            while (rs.next()) {
                Category category = new Category(
                        rs.getString("Category"),
                        rs.getString("NumAttractions")
                );
                data.add(category);
            }
            return data;

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public static Callback<TableColumn<Category, String>, TableCell<Category, String>> generateCellFactory(String column) {
        return new Callback<TableColumn<Category, String>, TableCell<Category, String>>() {
            @Override
            public TableCell<Category, String> call(TableColumn<Category, String> param) {
                return new TableCell<Category, String>() {
                    final Hyperlink link = new Hyperlink("");

                    @Override
                    public void updateItem(String item, boolean empty) {
                        super.updateItem(item, empty);
                        if (empty) {
                            setGraphic(null);
                            setText(null);
                        } else {
                            Category category = getTableView().getItems().get(getIndex());
                            if (column.equals("edit")) {
                                link.setText("Edit");
                                link.setOnAction(event -> {
                                    editCategory(category);
                                    RootView.instance.setCenter(CategoryView.getInstance());
                                });
                            } else if (column.equals("delete")) {
                                link.setText("Delete");
                                // TODO: implement delete
                            }
                            setGraphic(link);
                            setText(null);
                        }
                    }
                };
            }
        };
    }

    private static void editCategory(Category category) {
        TextInputDialog dialog = new TextInputDialog();
        dialog.setTitle("Edit Category");
        dialog.setHeaderText("Rename " + category.getCategoryName());
        dialog.setContentText("Please enter new category name.");
        Optional<String> result = dialog.showAndWait();
        result.ifPresent(s -> updateCategory(category, s));
    }

    private static void updateCategory(Category category, String newName) {
        String categoryUpdate = "UPDATE RateACity.Category\n" +
                "SET CName='" + newName + "'\n" +
                "WHERE CName='" + category.getCategoryName() + "';";
        try {
            DBConnection.connection.createStatement().executeUpdate(categoryUpdate);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}

