﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using LyncBillingBase.DataAttributes;

namespace LyncBillingBase.DataModels
{
    [DataSource(Name = "Countries", SourceType = Enums.DataSourceType.DBTable)]
    public class Country
    {
        //TODO: ADD ID COLUMN AND CLASS PROPERTY

        [DbColumn("CountryName")]
        public string Name { get; set; }

        [DbColumn("CountryCodeISO2")]
        public string CountryCodeISO2 { get; set; }

        [DbColumn("CountryCodeISO3")]
        public string CountryCodeISO3 { get; set; }

        [DbColumn("CurrencyName")]
        public string CurrencyName { get; set; }

        [DbColumn("CurrencyISOName")]
        public string CurrencyISOName { get; set; }
    }
}