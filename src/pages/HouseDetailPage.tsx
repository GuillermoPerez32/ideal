import { Button } from "@/components/ui/button";
import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";
import { Routes } from "@/enums";
import {
  Bath,
  Bed,
  Car,
  Coffee,
  Home,
  MapPin,
  Phone,
  Square,
  Trees,
} from "lucide-react";
import { useState } from "react";
import { Link } from "react-router-dom";

const HouseDetailPage = () => {
  const [currentImage, setCurrentImage] = useState(0);

  const house = {
    id: 1,
    title: "Casa moderna con vistas panorámicas",
    type: "sale",
    price: 450000,
    address: "123 Calle Principal, Ciudad, CP 12345",
    beds: 4,
    baths: 3,
    area: 200,
    garage: 2,
    yearBuilt: 2020,
    description:
      "Hermosa casa moderna con amplios espacios y vistas panorámicas. Perfecta para familias que buscan comodidad y estilo.",
    features: [
      "Cocina gourmet",
      "Terraza con vistas",
      "Sistema de seguridad",
      "Calefacción central",
      "Aire acondicionado",
    ],
    images: [
      "/placeholder.svg",
      "/placeholder.svg",
      "/placeholder.svg",
      "/placeholder.svg",
    ],
  };

  return (
    <div className="flex flex-col min-h-screen bg-white">
      <header className="px-4 lg:px-6 h-14 flex items-center border-b">
        <Link className="flex items-center justify-center" to={Routes.HOME}>
          <Home className="h-6 w-6 text-blue-600" />
          <span className="ml-2 text-lg font-semibold text-gray-900">
            Acme Real Estate
          </span>
        </Link>
      </header>
      <main className="flex-1 overflow-auto p-4 md:p-6 lg:p-8">
        <div className="max-w-4xl mx-auto">
          <h1 className="text-3xl font-bold mb-4 text-gray-900">
            {house.title}
          </h1>
          <div className="mb-6">
            <div className="relative aspect-video mb-4">
              <img
                src={house.images[currentImage]}
                alt={`House image ${currentImage + 1}`}
                className="w-full h-full object-cover rounded-lg"
              />
            </div>
            <div className="flex space-x-2 overflow-x-auto pb-2 ">
              {house.images.map((image, index) => (
                <img
                  key={index}
                  src={image}
                  alt={`House thumbnail ${index + 1}`}
                  className={`w-20 h-20 object-cover rounded cursor-pointer m-1 ${
                    index === currentImage ? "ring-2 ring-blue-600" : ""
                  }`}
                  onClick={() => setCurrentImage(index)}
                />
              ))}
            </div>
          </div>
          <div className="grid md:grid-cols-2 gap-6 mb-6">
            <Card>
              <CardHeader>
                <CardTitle className="text-gray-900">
                  Detalles de la propiedad
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="grid grid-cols-2 gap-4">
                  <div className="flex items-center text-gray-700">
                    <Bed className="w-5 h-5 mr-2" />
                    <span>{house.beds} Habitaciones</span>
                  </div>
                  <div className="flex items-center text-gray-700">
                    <Bath className="w-5 h-5 mr-2" />
                    <span>{house.baths} Baños</span>
                  </div>
                  <div className="flex items-center text-gray-700">
                    <Square className="w-5 h-5 mr-2" />
                    <span>{house.area} m²</span>
                  </div>
                  <div className="flex items-center text-gray-700">
                    <Car className="w-5 h-5 mr-2" />
                    <span>{house.garage} Garaje</span>
                  </div>
                  <div className="flex items-center text-gray-700">
                    <Trees className="w-5 h-5 mr-2" />
                    <span>Año {house.yearBuilt}</span>
                  </div>
                </div>
              </CardContent>
            </Card>
            <Card>
              <CardHeader>
                <CardTitle className="text-gray-900">
                  Precio y ubicación
                </CardTitle>
              </CardHeader>
              <CardContent>
                <div className="mb-4">
                  <div className="text-3xl font-bold text-yellow-600">
                    ${house.price.toLocaleString()}
                  </div>
                  <div className="text-gray-600">
                    {house.type === "rent"
                      ? "Alquiler mensual"
                      : "Precio de venta"}
                  </div>
                </div>
                <div className="flex items-start text-gray-700">
                  <MapPin className="w-5 h-5 mr-2 mt-1 flex-shrink-0" />
                  <span>{house.address}</span>
                </div>
              </CardContent>
            </Card>
          </div>
          <Card className="mb-6">
            <CardHeader>
              <CardTitle className="text-gray-900">Descripción</CardTitle>
            </CardHeader>
            <CardContent>
              <p className="text-gray-700">{house.description}</p>
            </CardContent>
          </Card>
          <Card className="mb-6">
            <CardHeader>
              <CardTitle className="text-gray-900">Características</CardTitle>
            </CardHeader>
            <CardContent>
              <ul className="grid grid-cols-2 md:grid-cols-3 gap-2">
                {house.features.map((feature, index) => (
                  <li key={index} className="flex items-center text-gray-700">
                    <Coffee className="w-5 h-5 mr-2" />
                    <span>{feature}</span>
                  </li>
                ))}
              </ul>
            </CardContent>
          </Card>
          <div className="flex flex-col sm:flex-row gap-4">
            <Button className="flex-1 bg-blue-600 text-white hover:bg-blue-700">
              <Phone className="w-5 h-5 mr-2" />
              Contactar agente
            </Button>
          </div>
        </div>
      </main>
    </div>
  );
};

export default HouseDetailPage;
