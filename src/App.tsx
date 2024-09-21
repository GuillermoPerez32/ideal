import { Building, DollarSign, Home, Key, Search } from "lucide-react";
import { Button } from "./components/ui/button";
import { Input } from "./components/ui/input";
import { Select } from "@radix-ui/react-select";
import {
  Card,
  CardContent,
  CardFooter,
  CardHeader,
  CardTitle,
} from "./components/ui/card";

function App() {
  return (
    <div className="flex flex-col min-h-screen">
      <header className="px-4 lg:px-6 h-14 flex items-center">
        <a className="flex items-center justify-center" href="#">
          <Home className="h-6 w-6" />
          <span className="sr-only">Acme Real Estate</span>
        </a>
        <nav className="ml-auto flex gap-4 sm:gap-6">
          <a
            className="text-sm font-medium hover:underline underline-offset-4"
            href="#"
          >
            Comprar
          </a>
          <a
            className="text-sm font-medium hover:underline underline-offset-4"
            href="#"
          >
            Alquilar
          </a>
          <a
            className="text-sm font-medium hover:underline underline-offset-4"
            href="#"
          >
            Vender
          </a>
          <a
            className="text-sm font-medium hover:underline underline-offset-4"
            href="#"
          >
            Contacto
          </a>
        </nav>
      </header>
      <main className="flex-1">
        <section className="w-full py-12 md:py-24 lg:py-32 xl:py-48 bg-black">
          <div className="container px-4 md:px-6">
            <div className="flex flex-col items-center space-y-4 text-center">
              <div className="space-y-2">
                <h1 className="text-3xl font-bold tracking-tighter sm:text-4xl md:text-5xl lg:text-6xl/none text-white">
                  Encuentra tu hogar ideal
                </h1>
                <p className="mx-auto max-w-[700px] text-gray-300 md:text-xl">
                  Explora miles de propiedades en venta y alquiler en toda la
                  ciudad.
                </p>
              </div>
              <div className="w-full max-w-sm space-y-2">
                <form className="flex space-x-2">
                  <Input
                    className="flex-1 bg-white"
                    placeholder="Buscar por ubicación..."
                    type="text"
                  />
                  <Select>
                    <option value="buy">Comprar</option>
                    <option value="rent">Alquilar</option>
                  </Select>
                  <Button type="submit">
                    <Search className="h-4 w-4 mr-2" />
                    Buscar
                  </Button>
                </form>
              </div>
            </div>
          </div>
        </section>
        <section className="w-full py-12 md:py-24 lg:py-32 bg-gray-100">
          <div className="container px-4 md:px-6">
            <h2 className="text-3xl font-bold tracking-tighter sm:text-5xl text-center mb-12">
              Nuestros servicios
            </h2>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              <Card>
                <CardHeader>
                  <Building className="h-8 w-8 mb-2" />
                  <CardTitle>Compra de propiedades</CardTitle>
                </CardHeader>
                <CardContent>
                  <p>
                    Encuentra la casa de tus sueños entre nuestra amplia
                    selección de propiedades en venta.
                  </p>
                </CardContent>
              </Card>
              <Card>
                <CardHeader>
                  <Key className="h-8 w-8 mb-2" />
                  <CardTitle>Alquiler de propiedades</CardTitle>
                </CardHeader>
                <CardContent>
                  <p>
                    Explora nuestras opciones de alquiler para encontrar el
                    lugar perfecto para vivir.
                  </p>
                </CardContent>
              </Card>
              <Card>
                <CardHeader>
                  <DollarSign className="h-8 w-8 mb-2" />
                  <CardTitle>Vende tu propiedad</CardTitle>
                </CardHeader>
                <CardContent>
                  <p>
                    Obtén la mejor valoración y vende tu propiedad de manera
                    rápida y segura con nosotros.
                  </p>
                </CardContent>
              </Card>
            </div>
          </div>
        </section>
        <section className="w-full py-12 md:py-24 lg:py-32">
          <div className="container px-4 md:px-6">
            <h2 className="text-3xl font-bold tracking-tighter sm:text-5xl text-center mb-12">
              Propiedades destacadas
            </h2>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              {[1, 2, 3].map((i) => (
                <Card key={i}>
                  <img
                    alt="Property"
                    className="w-full h-48 object-cover"
                    height="200"
                    src="https://placehold.co/600x400"
                    style={{
                      aspectRatio: "300/200",
                      objectFit: "cover",
                    }}
                    width="300"
                  />
                  <CardHeader>
                    <CardTitle>Casa moderna en el centro</CardTitle>
                  </CardHeader>
                  <CardContent>
                    <p>3 habitaciones • 2 baños • 150 m²</p>
                    <p className="font-bold mt-2">$250,000</p>
                  </CardContent>
                  <CardFooter>
                    <Button className="w-full">Ver detalles</Button>
                  </CardFooter>
                </Card>
              ))}
            </div>
          </div>
        </section>
        <section className="w-full py-12 md:py-24 lg:py-32 bg-gray-100">
          <div className="container px-4 md:px-6">
            <div className="flex flex-col items-center space-y-4 text-center">
              <div className="space-y-2">
                <h2 className="text-3xl font-bold tracking-tighter sm:text-4xl md:text-5xl">
                  ¿Listo para encontrar tu hogar ideal?
                </h2>
                <p className="mx-auto max-w-[700px] text-gray-500 md:text-xl/relaxed lg:text-base/relaxed xl:text-xl/relaxed">
                  Nuestros expertos están listos para ayudarte en cada paso del
                  camino.
                </p>
              </div>
              <div className="space-x-4">
                <Button>Contactar un agente</Button>
                <Button variant="outline">Explorar propiedades</Button>
              </div>
            </div>
          </div>
        </section>
      </main>
      <footer className="flex flex-col gap-2 sm:flex-row py-6 w-full shrink-0 items-center px-4 md:px-6 border-t">
        <p className="text-xs text-gray-500">
          © 2024 Acme Real Estate. Todos los derechos reservados.
        </p>
        <nav className="sm:ml-auto flex gap-4 sm:gap-6">
          <a className="text-xs hover:underline underline-offset-4" href="#">
            Términos de servicio
          </a>
          <a className="text-xs hover:underline underline-offset-4" href="#">
            Privacidad
          </a>
        </nav>
      </footer>
    </div>
  );
}

export default App;
