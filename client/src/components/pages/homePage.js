import React, { Component } from 'react';
import { connect } from "react-redux";

import keygen from "../../assets/keygen";

const mapStateToProps = store => {
  return {
    companies: store.companies
  };
};

class toConnectHomePage extends Component {
  state = {
    filter: ''
  };

  changeFilter = (e) => {
    this.setState({ filter: e.target.value });
  }

  filterCompanies = (companies) => {
    const regex = new RegExp(this.state.filter, 'gi');
    return companies.filter(comp => comp.name.match(regex))
  }

  render() {
    const companiesList = this.filterCompanies(this.props.companies).map(comp => <li key={keygen(comp.company_name)}><span>{comp.company_name}</span><span>{comp.company_branch_code}</span></li>);

    return (
      <div>
        <header>List Of Companies:</header>
        <ul className="comp__list">
          {companiesList}
        </ul>
        <div>
          <div>
            <label>Search: </label><input type="text" onChange={this.changeFilter} />
          </div>
          <button>Create New</button>
        </div>
      </div>
    );
  }
}

const HomePage = connect(mapStateToProps)(toConnectHomePage);

export default HomePage;
