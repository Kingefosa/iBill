﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LyncBillingBase.Helpers;

namespace LyncBillingBase.DAL
{
    [DataSource(DataSourceName = "GatewaysDetails", DataSource = Enums.DataSources.DBTable)]
    public class GatewayDetail
    {
        [IsIDField]
        [AllowIDInsert]
        [DbColumn("GatewayID")]
        public int GatewayID { set; get; }

        [DbColumn("SiteID")]
        public int SiteID { set; get; }

        [DbColumn("PoolID")]
        public int PoolID { set; get; }

        [AllowNull]
        [DbColumn("Description")]
        public string Description { set; get; }
    }
}
