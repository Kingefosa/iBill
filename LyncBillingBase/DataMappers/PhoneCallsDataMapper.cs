﻿using System;
using System.Collections.Generic;
using System.Linq;

using CCC.ORM;
using CCC.ORM.DataAccess;
using CCC.UTILS.Helpers;

using LyncBillingBase.DataMappers.SQLQueries;
using LyncBillingBase.DataModels;

namespace LyncBillingBase.DataMappers
{
    public class PhoneCallsDataMapper : DataAccess<PhoneCall>
    {
        private static readonly SitesDataMapper _sitesDataMapper = new SitesDataMapper();
        private static readonly DataSourceSchema<PhoneCall> _tableSchema = new DataSourceSchema<PhoneCall>();
        private static readonly MonitoringServersDataMapper _monitoringServersInfoDataMapper = new MonitoringServersDataMapper();

        //
        // The list of phone calls tables
        private readonly List<string> _dbTables = new List<string>();

        //
        // The SQL Queries Generator
        private readonly PhoneCallsSql _phonecallsSqlQueries = new PhoneCallsSql();


        /// <summary>
        /// CONSTRUCTOR
        /// </summary>
        public PhoneCallsDataMapper()
        {
            _dbTables = _monitoringServersInfoDataMapper.GetAll().Select(item => item.PhoneCallsTable).ToList();
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="sipAccount"></param>
        /// <returns></returns>
        public IEnumerable<PhoneCall> GetChargeableCallsBySipAccount(string sipAccount)
        {
            var sqlStatemnet = _phonecallsSqlQueries.ChargableCallsBySipAccount(_dbTables, sipAccount);

            return base.GetAll(sqlStatemnet);
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="siteName"></param>
        /// <returns></returns>
        public IEnumerable<PhoneCall> GetChargeableCallsBySiteDepartment(string departmentName)
        {
            //string sqlStatemnet = _phonecallsSqlQueries.ChargeableCallsBySiteDepartment(_dbTables, siteName);
            //return base.GetAll(sqlStatemnet);

            throw new NotImplementedException();
        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="siteName"></param>
        /// <returns></returns>
        public IEnumerable<PhoneCall> GetChargeableCallsBySiteName(string siteName)
        {
            var sqlStatemnet = _phonecallsSqlQueries.ChargeableCallsBySiteName(_dbTables, siteName);

            return base.GetAll(sqlStatemnet);
        }


        /// <summary>
        /// GetPendingDisputedPhoneCalls
        /// This is used to return the list of disputed calls per user that weren't evaluated by the accountants yet.
        /// Used in the Disputed page.
        /// </summary>
        /// <param name="siteName"></param>
        /// <returns></returns>
        public IEnumerable<PhoneCall> GetPendingDisputedCallsBySite(string siteName)
        {
            try
            {
                string sqlStatemnet = _phonecallsSqlQueries.GetDisputedCallsForSite(_dbTables, siteName);

                return base.GetAll(sqlStatemnet).Where(call => call.UiCallType == "Disputed");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
        
        /// <summary>
        /// GetEvalutedDisputedPhoneCalls
        /// This is used to return the list of disputed calls per user that weren't evaluated by the accountants yet.
        /// Used in the Disputed page.
        /// </summary>
        /// <param name="siteName"></param>
        /// <param name="wherePart"></param>
        /// <param name="limits"></param>
        /// <returns></returns>
        public IEnumerable<PhoneCall> GetEvaluatedDisputedCallsBySite(string siteName)
        {
            try
            {
                string sqlStatemnet = _phonecallsSqlQueries.GetDisputedCallsForSite(_dbTables, siteName);

                return base.GetAll(sqlStatemnet).Where(call => !string.IsNullOrEmpty(call.UiCallType) && call.UiCallType == "Accepted" && call.UiCallType == "Rejected");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        /// <summary>
        /// Charge the phone calls that were allocated by users as "Business/Personal" for a specific site in a specific period of time
        /// </summary>
        /// <param name="siteID"></param>
        /// <param name="fromDate"></param>
        /// <param name="toDate"></param>
        public void ChargeAllocatedPhoneCallsOfSite(int siteID, DateTime fromDate, DateTime toDate)
        {
            Site selectedSite = _sitesDataMapper.GetById(siteID);
            DateTime invoiceDate = DateTime.Now;

            string sqlStatement = _phonecallsSqlQueries.SP_InvoiceAllocatedChargeableCallsForSite(
                _dbTables,
                selectedSite.Name,
                fromDate.ConvertDate(excludeHoursAndMinutes: true),
                toDate.ConvertDate(excludeHoursAndMinutes: true),
                invoiceDate.ConvertDate(excludeHoursAndMinutes: true));

            try
            {
                base.Update(sqlStatement);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        /// <summary>
        /// Charge the suers' unallocated phone calls for a specific site in a specific period of time
        /// </summary>
        /// <param name="siteID"></param>
        /// <param name="fromDate"></param>
        /// <param name="toDate"></param>
        public void ChargeUnallocatedPhoneCallsOfSite(int siteID, DateTime fromDate, DateTime toDate)
        {
            Site selectedSite = _sitesDataMapper.GetById(siteID);
            DateTime invoiceDate = DateTime.Now;

            string sqlStatement = _phonecallsSqlQueries.SP_InvoiceUnallocatedChargeableCallsForSite(
                _dbTables,
                selectedSite.Name,
                fromDate.ConvertDate(excludeHoursAndMinutes: true),
                toDate.ConvertDate(excludeHoursAndMinutes: true),
                invoiceDate.ConvertDate(excludeHoursAndMinutes: true));

            try
            {
                base.Update(sqlStatement);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        /// <summary>
        /// Mark the unallocated users phone calls as pending charges.
        /// </summary>
        /// <param name="siteID"></param>
        /// <param name="fromDate"></param>
        /// <param name="toDate"></param>
        public void MarkUnallocatedPhoneCallsAsPending(int siteID, DateTime fromDate, DateTime toDate)
        {
            Site selectedSite = _sitesDataMapper.GetById(siteID);
            DateTime invoiceDate = DateTime.Now;

            string sqlStatement = _phonecallsSqlQueries.SP_MarkUnallocatedCallsAsPendingForSite(
                _dbTables,
                selectedSite.Name,
                fromDate.ConvertDate(excludeHoursAndMinutes: true),
                toDate.ConvertDate(excludeHoursAndMinutes: true),
                invoiceDate.ConvertDate(excludeHoursAndMinutes: true));

            try
            {
                base.Update(sqlStatement);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public override PhoneCall GetById(long id, string dataSourceName = null, Globals.DataSource.Type dataSource = Globals.DataSource.Type.Default)
        {
            throw new NotImplementedException();
        }


        public override IEnumerable<PhoneCall> GetAll(string dataSourceName = null, Globals.DataSource.Type dataSourceType = Globals.DataSource.Type.Default)
        {
            //string sqlStatement = sqlAccessor.GetAllPhoneCalls(dbTables);
            //return base.GetAll(SQL_QUERY: sqlStatement);

            throw new NotImplementedException();
        }


        public override int Insert(PhoneCall phoneCallObject, string dataSourceName = null, Globals.DataSource.Type dataSource = Globals.DataSource.Type.Default)
        {
            var finalDataSourceName = string.Empty;

            // NULL object check
            if (null == phoneCallObject)
            {
                throw new Exception("PhoneCalls#Insert: Cannot insert NULL phone call objects.");
            }

            // NULL check on the DataSource Name
            if (false == string.IsNullOrEmpty(dataSourceName))
            {
                finalDataSourceName = dataSourceName;
            }
            else
            {
                throw new Exception("PhoneCalls#Insert: Empty DataSource name. Couldn't insert phone call object.");
            }

            // Perform data insert
            try
            {
                return base.Insert(phoneCallObject, finalDataSourceName, dataSource);
            }
            catch (Exception ex)
            {
                throw ex.InnerException;
            }
        }


        public override bool Update(PhoneCall phoneCallObject, string dataSourceName = null, Globals.DataSource.Type dataSource = Globals.DataSource.Type.Default)
        {
            var finalDataSourceName = string.Empty;

            // NULL object check
            if (phoneCallObject == null)
            {
                throw new Exception("PhoneCalls#Update: Cannot update NULL phone call objects.");
            }

            // Decide on the value of the DataSource name
            if (false == string.IsNullOrEmpty(dataSourceName))
            {
                finalDataSourceName = dataSourceName;
            }
            else if (false == string.IsNullOrEmpty(phoneCallObject.PhoneCallsTableName))
            {
                finalDataSourceName = phoneCallObject.PhoneCallsTableName;
            }
            else
            {
                throw new Exception(
                    "PhoneCalls#Update: Both the DataSource name and the phoneCallObject.PhoneCallsTableName are NULL.");
            }

            // Perform data update 
            try
            {
                return base.Update(phoneCallObject, finalDataSourceName, dataSource);
            }
            catch (Exception ex)
            {
                throw ex.InnerException;
            }
        }


        public override bool Delete(PhoneCall phoneCallObject, string dataSourceName = null, Globals.DataSource.Type dataSource = Globals.DataSource.Type.Default)
        {
            var finalDataSourceName = string.Empty;

            // NULL object check
            if (null == phoneCallObject)
            {
                throw new Exception("PhoneCalls#Delete: Cannot delete NULL phone call objects.");
            }

            // Decide on the value of the DataSource name
            if (false == string.IsNullOrEmpty(dataSourceName))
            {
                finalDataSourceName = dataSourceName;
            }
            else if (false == string.IsNullOrEmpty(phoneCallObject.PhoneCallsTableName))
            {
                finalDataSourceName = phoneCallObject.PhoneCallsTableName;
            }
            else
            {
                throw new Exception(
                    "PhoneCalls#Delete: Both the DataSource name and the phoneCallObject.PhoneCallsTableName are NULL.");
            }

            // Perform data delete
            try
            {
                return base.Delete(phoneCallObject, dataSourceName, dataSource);
            }
            catch (Exception ex)
            {
                throw ex.InnerException;
            }
        }
    }

}