# AppSolve Application Blocks React Fast-api starter kit

This project is a starter kit for building full-stack web applications using React.js for the frontend and FastAPI for the backend. It is designed for flexibility, allowing you to run the application either within a containerized environment or as standalone services.

## To start in non container mode
### Frontend
```bash
cd frontend
npm install
npm run dev
```

### Backend
```bash
cd api
pip install -r requirements.txt
cd ..
uvicorn api:app --reload
```

## To run in container mode
```bash
chmod +c build-n-run.sh
sudo ./build-n-run.sh
```

Once started, api will run at port 8000 and frontend will run at port 3000  

Frontend  
`http://localhost:3000`  

Api  
`http://localhost:8000/docs`  
`http://localhost:8000/customers`  



