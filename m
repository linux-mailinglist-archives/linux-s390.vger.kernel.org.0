Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E6629E094
	for <lists+linux-s390@lfdr.de>; Thu, 29 Oct 2020 02:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732854AbgJ2BXM (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 28 Oct 2020 21:23:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729217AbgJ1WDx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Oct 2020 18:03:53 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09SD6CGj053096;
        Wed, 28 Oct 2020 09:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GPkrg1faGhAnb5qEhr2W1xGGU6lHuU3NtEEGtXOTBAg=;
 b=YhlWVbQXXsGRTsGyOH4mrHewunjjFAm5shiRgkT4Z2B1jXcF4hiYnHFSlThG1OflfZvL
 dW1NquLE8hT7EzTr+gv2NCpGJSOQ6VQ7LYQm+nzJXu7imeXLGV11NDtPi4UWNqw3vAJa
 TONDzS/c8ZXBKAH4RcVBMMupmR8jXdB6fNya3JNhbUdYttlDIgJMkEEQ9iR3btVNsM35
 YuCAukeiY/R5RhSlGO1UIlSNrO3tVqLFM0ycNn6dYQSYhOJIR4L/Vh9Murx41v8a/YUX
 7DqlaDRfOGB9hWi+Qf/DB/djikxYMuhukCKSoU3/2AHbOGBQKKG0W+ggBtBT+4vr7cbt mQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34f97u0pgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 09:23:13 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09SDD7Z4022135;
        Wed, 28 Oct 2020 13:23:11 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 34dwh0h88f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 13:23:11 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09SDN8si30605710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 13:23:08 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BF834C059;
        Wed, 28 Oct 2020 13:23:08 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 333BB4C052;
        Wed, 28 Oct 2020 13:23:08 +0000 (GMT)
Received: from oc5311105230.ibm.com (unknown [9.145.60.125])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Oct 2020 13:23:08 +0000 (GMT)
Subject: Re: [bug report] net/smc: CLC accept / confirm V2
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-s390@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>
References: <20201028112539.GA1155565@mwanda>
From:   Ursula Braun <ubraun@linux.ibm.com>
Message-ID: <6d16cfab-b512-3f57-cb91-26c762b3db0b@linux.ibm.com>
Date:   Wed, 28 Oct 2020 14:23:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201028112539.GA1155565@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-28_06:2020-10-26,2020-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=814 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1011 suspectscore=2 impostorscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280085
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 10/28/20 12:25 PM, Dan Carpenter wrote:
> Hello Ursula Braun,
> 
> The patch a7c9c5f4af7f: "net/smc: CLC accept / confirm V2" from Sep
> 26, 2020, leads to the following static checker warning:
> 
> 	net/smc/af_smc.c:1771 smc_listen_work()
> 	error: we previously assumed 'ini' could be null (see line 1715)
> 

Thanks for reporting this problem!
Karsten Graul provided already this fix on 10/23/20 (accepted by
Jakub Kicinski 10/27/20) for the net-tree:

   net/smc: fix null pointer dereference in smc_listen_decline()

   smc_listen_work() calls smc_listen_decline() on label out_decl,
   providing the ini pointer variable. But this pointer can still be null
   when the label out_decl is reached.
   Fix this by checking the ini variable in smc_listen_work() and call
   smc_listen_decline() with the result directly.

   Fixes: a7c9c5f4af7f ("net/smc: CLC accept / confirm V2")
   Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>

This fix is supposed to solve your reported problem.

Regards, Ursula Braun

> net/smc/af_smc.c
>   1665  static void smc_listen_work(struct work_struct *work)
>   1666  {
>   1667          struct smc_sock *new_smc = container_of(work, struct smc_sock,
>   1668                                                  smc_listen_work);
>   1669          u8 version = smc_ism_v2_capable ? SMC_V2 : SMC_V1;
>   1670          struct socket *newclcsock = new_smc->clcsock;
>   1671          struct smc_clc_msg_accept_confirm *cclc;
>   1672          struct smc_clc_msg_proposal_area *buf;
>   1673          struct smc_clc_msg_proposal *pclc;
>   1674          struct smc_init_info *ini = NULL;
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>   1675          int rc = 0;
>   1676  
>   1677          if (new_smc->listen_smc->sk.sk_state != SMC_LISTEN)
>   1678                  return smc_listen_out_err(new_smc);
>   1679  
>   1680          if (new_smc->use_fallback) {
>   1681                  smc_listen_out_connected(new_smc);
>   1682                  return;
>   1683          }
>   1684  
>   1685          /* check if peer is smc capable */
>   1686          if (!tcp_sk(newclcsock->sk)->syn_smc) {
>   1687                  smc_switch_to_fallback(new_smc);
>   1688                  new_smc->fallback_rsn = SMC_CLC_DECL_PEERNOSMC;
>   1689                  smc_listen_out_connected(new_smc);
>   1690                  return;
>   1691          }
>   1692  
>   1693          /* do inband token exchange -
>   1694           * wait for and receive SMC Proposal CLC message
>   1695           */
>   1696          buf = kzalloc(sizeof(*buf), GFP_KERNEL);
>   1697          if (!buf) {
>   1698                  rc = SMC_CLC_DECL_MEM;
>   1699                  goto out_decl;
>                         ^^^^^^^^^^^^^^
> There are several paths where "ini" is NULL leading to an Oops in the
> error handling.
> 
>   1700          }
>   1701          pclc = (struct smc_clc_msg_proposal *)buf;
>   1702          rc = smc_clc_wait_msg(new_smc, pclc, sizeof(*buf),
>   1703                                SMC_CLC_PROPOSAL, CLC_WAIT_TIME);
>   1704          if (rc)
>   1705                  goto out_decl;
>                         ^^^^^^^^^^^^^
> 
>   1706          version = pclc->hdr.version == SMC_V1 ? SMC_V1 : version;
>   1707  
>   1708          /* IPSec connections opt out of SMC optimizations */
>   1709          if (using_ipsec(new_smc)) {
>   1710                  rc = SMC_CLC_DECL_IPSEC;
>   1711                  goto out_decl;
>                         ^^^^^^^^^^^^^
> 
>   1712          }
>   1713  
>   1714          ini = kzalloc(sizeof(*ini), GFP_KERNEL);
>   1715          if (!ini) {
>   1716                  rc = SMC_CLC_DECL_MEM;
>   1717                  goto out_decl;
>                         ^^^^^^^^^^^^^
> 
>   1718          }
>   1719  
>   1720          /* initial version checking */
>   1721          rc = smc_listen_v2_check(new_smc, pclc, ini);
>   1722          if (rc)
>   1723                  goto out_decl;
>   1724  
>   1725          mutex_lock(&smc_server_lgr_pending);
>   1726          smc_close_init(new_smc);
>   1727          smc_rx_init(new_smc);
>   1728          smc_tx_init(new_smc);
>   1729  
>   1730          /* determine ISM or RoCE device used for connection */
>   1731          rc = smc_listen_find_device(new_smc, pclc, ini);
>   1732          if (rc)
>   1733                  goto out_unlock;
>   1734  
>   1735          /* send SMC Accept CLC message */
>   1736          rc = smc_clc_send_accept(new_smc, ini->first_contact_local,
>   1737                                   ini->smcd_version == SMC_V2 ? SMC_V2 : SMC_V1);
>   1738          if (rc)
>   1739                  goto out_unlock;
>   1740  
>   1741          /* SMC-D does not need this lock any more */
>   1742          if (ini->is_smcd)
>   1743                  mutex_unlock(&smc_server_lgr_pending);
>   1744  
>   1745          /* receive SMC Confirm CLC message */
>   1746          memset(buf, 0, sizeof(*buf));
>   1747          cclc = (struct smc_clc_msg_accept_confirm *)buf;
>   1748          rc = smc_clc_wait_msg(new_smc, cclc, sizeof(*buf),
>   1749                                SMC_CLC_CONFIRM, CLC_WAIT_TIME);
>   1750          if (rc) {
>   1751                  if (!ini->is_smcd)
>   1752                          goto out_unlock;
>   1753                  goto out_decl;
>   1754          }
>   1755  
>   1756          /* finish worker */
>   1757          if (!ini->is_smcd) {
>   1758                  rc = smc_listen_rdma_finish(new_smc, cclc,
>   1759                                              ini->first_contact_local);
>   1760                  if (rc)
>   1761                          goto out_unlock;
>   1762                  mutex_unlock(&smc_server_lgr_pending);
>   1763          }
>   1764          smc_conn_save_peer_info(new_smc, cclc);
>   1765          smc_listen_out_connected(new_smc);
>   1766          goto out_free;
>   1767  
>   1768  out_unlock:
>   1769          mutex_unlock(&smc_server_lgr_pending);
>   1770  out_decl:
>   1771          smc_listen_decline(new_smc, rc, ini, version);
>                                                 ^^^
> If "ini" is NULL then this will Oops.
> 
>   1772  out_free:
>   1773          kfree(ini);
>   1774          kfree(buf);
>   1775  }
> 
> regards,
> dan carpenter
> 
