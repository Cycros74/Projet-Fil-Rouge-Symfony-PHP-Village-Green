<?php

namespace App\Controller\Admin;

use App\Entity\Livreur;
use EasyCorp\Bundle\EasyAdminBundle\Config\Action;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Config\Actions;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use EasyCorp\Bundle\EasyAdminBundle\Field\MoneyField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextareaField;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;

class LivreurCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return Livreur::class;
    }

    // Pour désactiver les actions d'édition et de suppression du Dashboard
    public function configureActions(Actions $actions): Actions
    {
        return $actions
            ->disable(Action::EDIT, Action::DELETE);
    }

    public function configureFields(string $pageName): iterable
    {
        return [
            TextField::new('liv_nom', 'Nom'),
            TextareaField::new('liv_description', 'Description'),
            MoneyField::new('liv_prix', 'Prix')->setCurrency('EUR')
        ];
    }

}