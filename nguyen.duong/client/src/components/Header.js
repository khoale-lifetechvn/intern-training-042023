import { useEffect, useState } from "react";
import axios from "axios"
import Container from 'react-bootstrap/Container';
import Nav from 'react-bootstrap/Nav';
import Navbar from 'react-bootstrap/Navbar';
import { Link } from "react-router-dom";

const Header = () => {
    const [dataTable, setDataTable] = useState([])

    const fetchData = () => {
        axios.get("http://localhost:3001/table")
            .then((res) => {
                const dt = res.data
                return dt
            }).then((dt) => {
                setDataTable(dt)
            })
            .catch(error => console.log(error))
    }

    useEffect(() => {
        fetchData()
    }, [])
    return (
            <Navbar bg="light" expand="lg">
                <Container fluid>
                    <Navbar.Brand href="/">Trang chủ</Navbar.Brand>
                    <Navbar.Toggle aria-controls="navbarScroll" />
                    <Navbar.Collapse id="navbarScroll">
                        <Nav
                            className="me-auto my-2 my-lg-0"
                            style={{ maxHeight: '100px' }}
                            navbarScroll
                        >
                            {dataTable.map(
                                item => <Link className="nav-link" to={`/table/${item.Tables_in_db_docker}`}>{item.Tables_in_db_docker}</Link>
                            )}
                        </Nav>
                    </Navbar.Collapse>
                </Container>
            </Navbar>
    )
}

export default Header