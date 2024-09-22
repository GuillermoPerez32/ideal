import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import { createBrowserRouter, RouterProvider } from "react-router-dom";
import "./index.css";
import HomePage from "./pages/HomePage";
import HousesPage from "./pages/HousesPage";
import { Routes } from "./enums";
import HouseDetailPage from "./pages/HouseDetailPage";

const router = createBrowserRouter([
  {
    path: Routes.HOME,
    element: <HomePage />,
  },
  {
    path: Routes.HOUSES,
    element: <HousesPage />,
  },
  {
    path: Routes.HOUSE_DETAIL,
    element: <HouseDetailPage />,
  },
]);

createRoot(document.getElementById("root")!).render(
  <StrictMode>
    <RouterProvider router={router} />
  </StrictMode>
);
