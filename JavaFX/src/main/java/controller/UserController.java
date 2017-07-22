package main.java.controller;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import main.java.sql.DBConnection;

import java.sql.ParameterMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by Rob on 7/21/2017.
 */
public class UserController {
    public static ObservableList<String> cityNamesList() {
        return cityNamesList("");
    }

    public static ObservableList<String> cityNamesList(String sort) {
        ObservableList<String> cityNamesList = FXCollections.observableArrayList();

        String cityNamesQuery =
                "SELECT CityName FROM RateACity.City \n" +
                "JOIN RateACity.REVIEWABLE_ENTITY ON CITY.CityEID=REVIEWABLE_ENTITY.EntityID \n" +
                "WHERE isPending = 0";
        if (sort.equals("A -> Z")) {
            cityNamesQuery += " ORDER BY CityName ASC";
        } else if (sort.equals("Z -> A")){
            cityNamesQuery += " ORDER BY CityName DESC";
        }

        try {
            ResultSet rs = DBConnection.connection.createStatement().executeQuery(cityNamesQuery);
            while (rs.next()) {
                cityNamesList.add(rs.getString("CityName"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return cityNamesList;
    }

    public static ObservableList<String> categoriesList() {
        return categoriesList("");
    }

    public static ObservableList<String> categoriesList(String sort) {
        ObservableList<String> categoriesList = FXCollections.observableArrayList();

        String cityNamesQuery = "SELECT CName FROM RateACity.Category";
        if (sort.equals("A -> Z")) {
            cityNamesQuery += " ORDER BY CName ASC";
        } else if (sort.equals("Z -> A")){
            cityNamesQuery += " ORDER BY CName DESC";
        }

        try {
            ResultSet rs = DBConnection.connection.createStatement().executeQuery(cityNamesQuery);
            while (rs.next()) {
                categoriesList.add(rs.getString("CName"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return categoriesList;
    }
}