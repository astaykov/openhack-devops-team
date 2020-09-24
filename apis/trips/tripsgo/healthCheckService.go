package tripsgo

import (
	"encoding/json"
	"net/http"
)

func healthcheckGet(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)

<<<<<<< HEAD
	hc := &Healthcheck{Message: "Trip Service Healthcheck", Status: "NOT SO Healthy"}
=======
	hc := &Healthcheck{Message: "Trip Service Healthcheck", Status: "not Healthy"}
>>>>>>> d8b7f5866ba704a631b3c4ba4f0da81c44eff946

	json.NewEncoder(w).Encode(hc)
}
