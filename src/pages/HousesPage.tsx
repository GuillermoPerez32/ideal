import { Button } from "@/components/ui/button";
import {
  Card,
  CardContent,
  CardFooter,
  CardHeader,
  CardTitle,
} from "@/components/ui/card";
import { Routes } from "@/enums";
import { Bath, Bed, Home, Square } from "lucide-react";
import { useState } from "react";
import { Link } from "react-router-dom";

const HousesPage = () => {
  const [listingType, setListingType] = useState<"rent" | "sale">("rent");

  const houses = [
    {
      id: 1,
      type: "rent",
      title: "Apartamento moderno",
      price: 1200,
      beds: 2,
      baths: 1,
      area: 75,
    },
    {
      id: 2,
      type: "sale",
      title: "Casa familiar",
      price: 250000,
      beds: 4,
      baths: 2,
      area: 150,
    },
    {
      id: 3,
      type: "rent",
      title: "Estudio céntrico",
      price: 800,
      beds: 1,
      baths: 1,
      area: 40,
    },
    {
      id: 4,
      type: "sale",
      title: "Chalet con jardín",
      price: 350000,
      beds: 5,
      baths: 3,
      area: 200,
    },
    {
      id: 5,
      type: "rent",
      title: "Loft industrial",
      price: 1500,
      beds: 2,
      baths: 2,
      area: 90,
    },
    {
      id: 6,
      type: "sale",
      title: "Adosado nuevo",
      price: 180000,
      beds: 3,
      baths: 2,
      area: 120,
    },
  ];

  const filteredHouses = houses.filter((house) => house.type === listingType);

  return (
    <div className="flex flex-col min-h-screen bg-white">
      <header className="px-4 lg:px-6 h-14 flex items-center border-b">
        <Link to={Routes.HOME} className="flex items-center justify-center">
          <Home className="h-6 w-6 text-blue-600" />
          <span className="ml-2 text-lg font-semibold text-gray-900">
            Acme Real Estate
          </span>
        </Link>
      </header>
      <main className="flex-1 overflow-auto p-4">
        <h1 className="text-2xl font-bold mb-6 text-gray-900">
          {listingType === "rent" ? "Casas en alquiler" : "Casas en venta"}
        </h1>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {filteredHouses.map((house) => (
            <Card key={house.id}>
              <CardHeader>
                <CardTitle className="text-gray-900">{house.title}</CardTitle>
              </CardHeader>
              <CardContent>
                <img
                  src="/placeholder.svg"
                  alt={house.title}
                  className="w-full h-48 object-cover mb-4 rounded"
                />
                <div className="flex justify-between items-center mb-2">
                  <span className="font-bold text-lg text-yellow-600">
                    {house.type === "rent"
                      ? `$${house.price}/mes`
                      : `$${house.price.toLocaleString()}`}
                  </span>
                  <span className="text-gray-600">
                    {house.type === "rent" ? "Alquiler" : "Venta"}
                  </span>
                </div>
                <div className="flex justify-between text-sm text-gray-600">
                  <span className="flex items-center">
                    <Bed className="w-4 h-4 mr-1" /> {house.beds} hab.
                  </span>
                  <span className="flex items-center">
                    <Bath className="w-4 h-4 mr-1" /> {house.baths} baños
                  </span>
                  <span className="flex items-center">
                    <Square className="w-4 h-4 mr-1" /> {house.area} m²
                  </span>
                </div>
              </CardContent>
              <CardFooter>
                <Link to={`/${Routes.HOUSES}/${house.id}`}>
                  <Button className="w-full bg-blue-600 text-white hover:bg-blue-700">
                    Ver detalles
                  </Button>
                </Link>
              </CardFooter>
            </Card>
          ))}
        </div>
      </main>
      <nav className="fixed bottom-0 left-0 right-0 flex justify-around p-4 bg-white border-t">
        <Button
          onClick={() => setListingType("rent")}
          variant={listingType === "rent" ? "default" : "outline"}
          className={
            listingType === "rent" ? "bg-blue-600 text-white" : "text-gray-900"
          }
        >
          Alquiler
        </Button>
        <Button
          onClick={() => setListingType("sale")}
          variant={listingType === "sale" ? "default" : "outline"}
          className={
            listingType === "sale" ? "bg-blue-600 text-white" : "text-gray-900"
          }
        >
          Venta
        </Button>
      </nav>
    </div>
  );
};

export default HousesPage;
