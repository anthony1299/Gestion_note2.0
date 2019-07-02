package org.isj.interfaces.controller;

import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.TextField;
import javafx.scene.layout.AnchorPane;
import javafx.stage.DirectoryChooser;
import javafx.stage.FileChooser;
import javafx.stage.Stage;
import org.isj.metier.Isj;
import org.jfree.ui.ExtensionFileFilter;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;




public class EmplacementFichierController implements Initializable {

    @FXML
    private TextField parcourir;

    @FXML
    private AnchorPane anchorid;

    public EmplacementFichierController() {
    }

    /*@FXML
    public void handleButtonAction (ActionEvent event){

        final DirectoryChooser dirchooser = new DirectoryChooser();

        Stage stage = (Stage) anchorid.getScene().getWindow();

        File file = dirchooser.showDialog(stage);

        if(file !=null)
        {
            System.out.println("Path : " + file.getAbsolutePath());

        }
    }*/
    @Override
    public void initialize(URL location, ResourceBundle resources) {

    }

    public void handleButtonAction(javafx.event.ActionEvent actionEvent) throws IOException {

        FileChooser dirchooser = new FileChooser();
        dirchooser.setTitle("Open resource File");
        dirchooser.getExtensionFilters().addAll(new FileChooser.ExtensionFilter("Excel files", "*.xlsx"));
               /* new FileChooser.ExtensionFilter("Image Files", "*.png", "*.jpg", "*.gif"),
                new FileChooser.ExtensionFilter()*/

        Stage stage = (Stage) anchorid.getScene().getWindow();

        File file = dirchooser.showOpenDialog(stage);
        parcourir.setText(file.getAbsolutePath());

        /*if(file !=null)
        {
            System.out.println("Path : " + file.getAbsolutePath());

        }*/

        Isj isj = new Isj();
        isj.enregistrerNoteExcel(file.getAbsolutePath());
    }
}
