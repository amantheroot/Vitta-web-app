import React, { Component } from 'react';
import { connect } from "react-redux";
import { BrowserRouter, Route, Switch } from "react-router-dom";

import {fetchCompanies} from "./actions/companiesActions";
import {fetchProducts} from "./actions/productsActions";
import {fetchStocks} from "./actions/stocksActions";
import {fetchCustomers} from "./actions/customersActions";
import {fetchSuppliers} from "./actions/suppliersActions";
import {fetchOrders} from "./actions/ordersActions";

import Layout from "./components/layout";

import HomePage from "./components/pages/homePage";
import CreateCompany from "./components/pages/createCompany";

const mapStateToProps = store => {
  return {
    companies: store.companies,
    products: store.products,
    stocks: store.stocks,
    customers: store.customers,
    suppliers: store.suppliers,
    orders: store.orders
  };
};

class toConnectApp extends Component {
  componentWillMount() {
    this.getData();
  }

  getData = () => {
    fetch('/api/data')
      .then(res => res.json())
      .then(data => this.handleData(data));
  }

  handleData = data => {
    this.props.dispatch(fetchCompanies(data.companies));
    this.props.dispatch(fetchProducts(data.products));
    this.props.dispatch(fetchStocks(data.stocks));
    this.props.dispatch(fetchCustomers(data.customers));
    this.props.dispatch(fetchSuppliers(data.suppliers));
    this.props.dispatch(fetchOrders(data.orders));
  }

  render() {
    return (
      <BrowserRouter>
        <Layout>
          <Switch>
            <Route path="/" component={HomePage} exact />
            <Route path="/createcompany" component={CreateCompany} />
          </Switch>
        </Layout>
      </BrowserRouter>
    );
  }
}

const App = connect(mapStateToProps)(toConnectApp);

export default App;
