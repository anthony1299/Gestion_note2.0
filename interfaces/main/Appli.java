package org.isj.interfaces.main;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;
import javafx.stage.Window;
import org.isj.gestionutilisateurs.Connexion;
import org.isj.metier.Isj;
import org.isj.metier.entites.Role;
import org.isj.metier.entites.Utilisateur;
import org.isj.metier.facade.RoleFacade;
import org.isj.metier.facade.UtilisateurFacade;

import java.io.IOException;

import static org.isj.gestionutilisateurs.Connexion.utilisateurCourant;

public class Appli extends Application {

    public static Window getPrimaryStage;
    private Stage primaryStage;

    @Override
    public void start(Stage primaryStage) {
        try{
            this.primaryStage = primaryStage;
            this.primaryStage.setTitle("ISJ Application");

            showSeConnecter();
        }catch (Exception e){
            e.printStackTrace();
            e.getMessage();
        }

    }

    public void showSeConnecter(){
        try {

            FXMLLoader loader = new FXMLLoader();
            loader.setLocation(Appli.class.getResource("../view/Connexion.fxml"));
            AnchorPane connex = loader.load();

            Scene fen = new Scene(connex);
            primaryStage.setScene(fen);
            primaryStage.show();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    public Stage getPrimaryStage(){

        return primaryStage;
    }

    public static void main(String[] args) {

        //System.out.println(new Connexion().hachage("123456"));
        /*System.out.println(new Connexion().hachage("123456"));
        Isj isj=new Isj();

         utilisateurCourant=new UtilisateurFacade().find(new Long(1));
         String role=new RoleFacade().enregistrer("Role Test","");
         System.out.println("Role = [" + role + "]");
         Role role=new RoleFacade().find(new Long(651));
         isj.creerDroitRole(role);
         isj.affecterUtilisateurRole(utilisateurCourant,role);*/

        launch(args);
    }
}
