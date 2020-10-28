Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C43329D290
	for <lists+linux-s390@lfdr.de>; Wed, 28 Oct 2020 22:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgJ1VdV (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 28 Oct 2020 17:33:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43772 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgJ1VdU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 28 Oct 2020 17:33:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SBP4xk059973;
        Wed, 28 Oct 2020 11:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=0EJGMrLzPnA8igX+X9zVVa7mfgh8JcHWtJikU5BwPXo=;
 b=pGSX1pUxr4D0d/fqYn1ZG1rZrb6qBNCAbuWhiw1P6wGIINFitKOvJ9wiqt0XCyeazxUi
 bW+UKtSk3W+N/SRXd3Ru8A6UKWGeOsU3GVMZJ4Itg0ghGvkbIxQaLkWcCCwniIB8dIG2
 O7ondec4m+ISTJgWa2CUWaYosaizg4M3rFTS6m3jwpmih0J4diN7cK7efSf5YeCMmdjd
 iDqrA5jaXtG7cDp1d3Ie8yMBn2UqCaT8CAJ/QzXjqoitJ9Icntzc40mpF4S0EDQE/q80
 6YfvB5iZFfAx9pu9sXORUkH/2PRw2qb31Ij1HiNhu9pO18rEjCSRJilIBpKEl25q/lQf Eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34cc7kxw5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 11:28:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SBQ5vB065154;
        Wed, 28 Oct 2020 11:26:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 34cx5y7fft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 11:26:05 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09SBQ5hH021435;
        Wed, 28 Oct 2020 11:26:05 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Oct 2020 04:26:04 -0700
Date:   Wed, 28 Oct 2020 14:25:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ubraun@linux.ibm.com
Cc:     linux-s390@vger.kernel.org
Subject: [bug report] net/smc: CLC accept / confirm V2
Message-ID: <20201028112539.GA1155565@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=912
 suspectscore=10 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1011 mlxscore=0 suspectscore=10
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=928 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280078
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello Ursula Braun,

The patch a7c9c5f4af7f: "net/smc: CLC accept / confirm V2" from Sep
26, 2020, leads to the following static checker warning:

	net/smc/af_smc.c:1771 smc_listen_work()
	error: we previously assumed 'ini' could be null (see line 1715)

net/smc/af_smc.c
  1665  static void smc_listen_work(struct work_struct *work)
  1666  {
  1667          struct smc_sock *new_smc = container_of(work, struct smc_sock,
  1668                                                  smc_listen_work);
  1669          u8 version = smc_ism_v2_capable ? SMC_V2 : SMC_V1;
  1670          struct socket *newclcsock = new_smc->clcsock;
  1671          struct smc_clc_msg_accept_confirm *cclc;
  1672          struct smc_clc_msg_proposal_area *buf;
  1673          struct smc_clc_msg_proposal *pclc;
  1674          struct smc_init_info *ini = NULL;
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  1675          int rc = 0;
  1676  
  1677          if (new_smc->listen_smc->sk.sk_state != SMC_LISTEN)
  1678                  return smc_listen_out_err(new_smc);
  1679  
  1680          if (new_smc->use_fallback) {
  1681                  smc_listen_out_connected(new_smc);
  1682                  return;
  1683          }
  1684  
  1685          /* check if peer is smc capable */
  1686          if (!tcp_sk(newclcsock->sk)->syn_smc) {
  1687                  smc_switch_to_fallback(new_smc);
  1688                  new_smc->fallback_rsn = SMC_CLC_DECL_PEERNOSMC;
  1689                  smc_listen_out_connected(new_smc);
  1690                  return;
  1691          }
  1692  
  1693          /* do inband token exchange -
  1694           * wait for and receive SMC Proposal CLC message
  1695           */
  1696          buf = kzalloc(sizeof(*buf), GFP_KERNEL);
  1697          if (!buf) {
  1698                  rc = SMC_CLC_DECL_MEM;
  1699                  goto out_decl;
                        ^^^^^^^^^^^^^^
There are several paths where "ini" is NULL leading to an Oops in the
error handling.

  1700          }
  1701          pclc = (struct smc_clc_msg_proposal *)buf;
  1702          rc = smc_clc_wait_msg(new_smc, pclc, sizeof(*buf),
  1703                                SMC_CLC_PROPOSAL, CLC_WAIT_TIME);
  1704          if (rc)
  1705                  goto out_decl;
                        ^^^^^^^^^^^^^

  1706          version = pclc->hdr.version == SMC_V1 ? SMC_V1 : version;
  1707  
  1708          /* IPSec connections opt out of SMC optimizations */
  1709          if (using_ipsec(new_smc)) {
  1710                  rc = SMC_CLC_DECL_IPSEC;
  1711                  goto out_decl;
                        ^^^^^^^^^^^^^

  1712          }
  1713  
  1714          ini = kzalloc(sizeof(*ini), GFP_KERNEL);
  1715          if (!ini) {
  1716                  rc = SMC_CLC_DECL_MEM;
  1717                  goto out_decl;
                        ^^^^^^^^^^^^^

  1718          }
  1719  
  1720          /* initial version checking */
  1721          rc = smc_listen_v2_check(new_smc, pclc, ini);
  1722          if (rc)
  1723                  goto out_decl;
  1724  
  1725          mutex_lock(&smc_server_lgr_pending);
  1726          smc_close_init(new_smc);
  1727          smc_rx_init(new_smc);
  1728          smc_tx_init(new_smc);
  1729  
  1730          /* determine ISM or RoCE device used for connection */
  1731          rc = smc_listen_find_device(new_smc, pclc, ini);
  1732          if (rc)
  1733                  goto out_unlock;
  1734  
  1735          /* send SMC Accept CLC message */
  1736          rc = smc_clc_send_accept(new_smc, ini->first_contact_local,
  1737                                   ini->smcd_version == SMC_V2 ? SMC_V2 : SMC_V1);
  1738          if (rc)
  1739                  goto out_unlock;
  1740  
  1741          /* SMC-D does not need this lock any more */
  1742          if (ini->is_smcd)
  1743                  mutex_unlock(&smc_server_lgr_pending);
  1744  
  1745          /* receive SMC Confirm CLC message */
  1746          memset(buf, 0, sizeof(*buf));
  1747          cclc = (struct smc_clc_msg_accept_confirm *)buf;
  1748          rc = smc_clc_wait_msg(new_smc, cclc, sizeof(*buf),
  1749                                SMC_CLC_CONFIRM, CLC_WAIT_TIME);
  1750          if (rc) {
  1751                  if (!ini->is_smcd)
  1752                          goto out_unlock;
  1753                  goto out_decl;
  1754          }
  1755  
  1756          /* finish worker */
  1757          if (!ini->is_smcd) {
  1758                  rc = smc_listen_rdma_finish(new_smc, cclc,
  1759                                              ini->first_contact_local);
  1760                  if (rc)
  1761                          goto out_unlock;
  1762                  mutex_unlock(&smc_server_lgr_pending);
  1763          }
  1764          smc_conn_save_peer_info(new_smc, cclc);
  1765          smc_listen_out_connected(new_smc);
  1766          goto out_free;
  1767  
  1768  out_unlock:
  1769          mutex_unlock(&smc_server_lgr_pending);
  1770  out_decl:
  1771          smc_listen_decline(new_smc, rc, ini, version);
                                                ^^^
If "ini" is NULL then this will Oops.

  1772  out_free:
  1773          kfree(ini);
  1774          kfree(buf);
  1775  }

regards,
dan carpenter
