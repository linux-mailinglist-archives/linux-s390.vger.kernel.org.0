Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EEA5959B5
	for <lists+linux-s390@lfdr.de>; Tue, 16 Aug 2022 13:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbiHPLTA (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 16 Aug 2022 07:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbiHPLSf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 16 Aug 2022 07:18:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEAAC0B5B;
        Tue, 16 Aug 2022 02:43:37 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27G8TxJE012925;
        Tue, 16 Aug 2022 09:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Rv8xdJA7vSQn+Lvuxzfy4s1XdtFhDIF0JEJag95PiAA=;
 b=i9BThtRJessCkq4llfEAib+JmOzGmnF05lyuU+sJT/v4ZA9eS/S70YkFPGVhJV7glRMr
 XV3n0rwTQyfiYqumYT77cSc6oC+oGAEln1v/Ok4St0GJJJ1EeuB0U4rVlgyQXO7cOASH
 i/DVI/dYBjUm8/VQTsDptImftciJJjY2fNayWxRoNcAen+L62WnwskHCbaFeCennuaWr
 C2pTGiEFffCvoJmPaOLGYRC23w3pyyODnM0Pd4Ktu26d0nAWwci3YVuPsQDd6vDuZ0Wy
 ncHwBE+55k84cx0nJCtdJo5FDKCEhteQUteUXZpsbAcJdrv3HNVwIsRUo4oYi1Nhvf+O mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3j07sf1xfp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 09:43:31 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27G9CpcP007925;
        Tue, 16 Aug 2022 09:43:30 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3j07sf1xf2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 09:43:30 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27G9KY9h011629;
        Tue, 16 Aug 2022 09:43:29 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3hx3k9281v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 09:43:28 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27G9hPTO19661108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Aug 2022 09:43:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33E24AE07B;
        Tue, 16 Aug 2022 09:43:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B19AAE058;
        Tue, 16 Aug 2022 09:43:24 +0000 (GMT)
Received: from [9.171.58.165] (unknown [9.171.58.165])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 16 Aug 2022 09:43:24 +0000 (GMT)
Message-ID: <853f7c69-8690-1ceb-9256-af5c2a5b2ae0@linux.ibm.com>
Date:   Tue, 16 Aug 2022 11:43:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH net-next 01/10] net/smc: remove locks
 smc_client_lgr_pending and smc_server_lgr_pending
Content-Language: en-US
To:     "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <cover.1660152975.git.alibuda@linux.alibaba.com>
 <075ff0be35660efac638448cdae7f7e7e04199d4.1660152975.git.alibuda@linux.alibaba.com>
From:   Jan Karcher <jaka@linux.ibm.com>
In-Reply-To: <075ff0be35660efac638448cdae7f7e7e04199d4.1660152975.git.alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _wXscraYCEq84nc4HlbDJlFmGRn1vgyy
X-Proofpoint-ORIG-GUID: vqfbyFtUyxyWCvOqM2WMeCAWuF25ovi7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-16_07,2022-08-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208160037
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 10.08.2022 19:47, D. Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> This patch attempts to remove locks named smc_client_lgr_pending and
> smc_server_lgr_pending, which aim to serialize the creation of link
> group. However, once link group existed already, those locks are
> meaningless, worse still, they make incoming connections have to be
> queued one after the other.
> 
> Now, the creation of link group is no longer generated by competition,
> but allocated through following strategy.
> 
> 1. Try to find a suitable link group, if successd, current connection
> is considered as NON first contact connection. ends.
> 
> 2. Check the number of connections currently waiting for a suitable
> link group to be created, if it is not less that the number of link
> groups to be created multiplied by (SMC_RMBS_PER_LGR_MAX - 1), then
> increase the number of link groups to be created, current connection
> is considered as the first contact connection. ends.
> 
> 3. Increase the number of connections currently waiting, and wait
> for woken up.
> 
> 4. Decrease the number of connections currently waiting, goto 1.
> 
> We wake up the connection that was put to sleep in stage 3 through
> the SMC link state change event. Once the link moves out of the
> SMC_LNK_ACTIVATING state, decrease the number of link groups to
> be created, and then wake up at most (SMC_RMBS_PER_LGR_MAX - 1)
> connections.
> 
> In the iplementation, we introduce the concept of lnk cluster, which is
> a collection of links with the same characteristics (see
> smcr_lnk_cluster_cmpfn() with more details), which makes it possible to
> wake up efficiently in the scenario of N v.s 1.
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>   net/smc/af_smc.c   |  11 +-
>   net/smc/smc_core.c | 356 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   net/smc/smc_core.h |  48 ++++++++
>   net/smc/smc_llc.c  |   9 +-
>   4 files changed, 411 insertions(+), 13 deletions(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index 79c1318..af4b0aa 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1194,10 +1194,8 @@ static int smc_connect_rdma(struct smc_sock *smc,
>   	if (reason_code)
>   		return reason_code;
> 
> -	mutex_lock(&smc_client_lgr_pending);
>   	reason_code = smc_conn_create(smc, ini);
>   	if (reason_code) {
> -		mutex_unlock(&smc_client_lgr_pending);
>   		return reason_code;
>   	}
> 
> @@ -1289,7 +1287,6 @@ static int smc_connect_rdma(struct smc_sock *smc,
>   		if (reason_code)
>   			goto connect_abort;
>   	}
> -	mutex_unlock(&smc_client_lgr_pending);
> 
>   	smc_copy_sock_settings_to_clc(smc);
>   	smc->connect_nonblock = 0;
> @@ -1299,7 +1296,6 @@ static int smc_connect_rdma(struct smc_sock *smc,
>   	return 0;
>   connect_abort:
>   	smc_conn_abort(smc, ini->first_contact_local);
> -	mutex_unlock(&smc_client_lgr_pending);
>   	smc->connect_nonblock = 0;
> 
>   	return reason_code;


You are removing the locking mechanism out of this function completly, 
which is fine because it is only called for a SMC-R connection.


> @@ -2377,7 +2373,8 @@ static void smc_listen_work(struct work_struct *work)
>   	if (rc)
>   		goto out_decl;
> 
> -	mutex_lock(&smc_server_lgr_pending);
> +	if (ini->is_smcd)
> +		mutex_lock(&smc_server_lgr_pending);
>   	smc_close_init(new_smc);
>   	smc_rx_init(new_smc);
>   	smc_tx_init(new_smc);
> @@ -2415,7 +2412,6 @@ static void smc_listen_work(struct work_struct *work)
>   					    ini->first_contact_local, ini);
>   		if (rc)
>   			goto out_unlock;
> -		mutex_unlock(&smc_server_lgr_pending);
>   	}
>   	smc_conn_save_peer_info(new_smc, cclc);
>   	smc_listen_out_connected(new_smc);
> @@ -2423,7 +2419,8 @@ static void smc_listen_work(struct work_struct *work)
>   	goto out_free;
> 
>   out_unlock:
> -	mutex_unlock(&smc_server_lgr_pending);
> +	if (ini->is_smcd)
> +		mutex_unlock(&smc_server_lgr_pending);


You want to remove the mutex lock for SMC-R so you are only locking for 
a SMC-D connection. So far so good. I think you could also remove this 
unlock call since it is only called in the case of a SMC-R connection - 
which means it is obsolete:

l2398 ff. (with your patch on net-next)

     /* receive SMC Confirm CLC message */
     memset(buf, 0, sizeof(*buf));
     cclc = (struct smc_clc_msg_accept_confirm *)buf;
     rc = smc_clc_wait_msg(new_smc, cclc, sizeof(*buf),
                   SMC_CLC_CONFIRM, CLC_WAIT_TIME);
     if (rc) {
x        if (!ini->is_smcd)
x            goto out_unlock;
         goto out_decl;
     }

>   out_decl:
>   	smc_listen_decline(new_smc, rc, ini ? ini->first_contact_local : 0,
>   			   proposal_version);
> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> index ff49a11..a3338cc 100644
> --- a/net/smc/smc_core.c
> +++ b/net/smc/smc_core.c
> @@ -46,6 +46,10 @@ struct smc_lgr_list smc_lgr_list = {	/* established link groups */
>   	.num = 0,
>   };
> 
> +struct smc_lgr_manager smc_lgr_manager = {
> +	.lock = __SPIN_LOCK_UNLOCKED(smc_lgr_manager.lock),
> +};
> +
>   static atomic_t lgr_cnt = ATOMIC_INIT(0); /* number of existing link groups */
>   static DECLARE_WAIT_QUEUE_HEAD(lgrs_deleted);
> 
> @@ -55,6 +59,282 @@ static void smc_buf_free(struct smc_link_group *lgr, bool is_rmb,
> 
>   static void smc_link_down_work(struct work_struct *work);
> 
> +/* SMC-R lnk cluster compare func
> + * All lnks that meet the description conditions of this function
> + * are logically aggregated, called lnk cluster.
> + * For the server side, lnk cluster is used to determine whether
> + * a new group needs to be created when processing new imcoming connections.
> + * For the client side, lnk cluster is used to determine whether
> + * to wait for link ready (in other words, first contact ready).
> + */
> +static int smcr_lnk_cluster_cmpfn(struct rhashtable_compare_arg *arg, const void *obj)
> +{
> +	const struct smc_lnk_cluster_compare_arg *key = arg->key;
> +	const struct smc_lnk_cluster *lnkc = obj;
> +
> +	if (memcmp(key->peer_systemid, lnkc->peer_systemid, SMC_SYSTEMID_LEN))
> +		return 1;
> +
> +	if (memcmp(key->peer_gid, lnkc->peer_gid, SMC_GID_SIZE))
> +		return 1;
> +
> +	if ((key->role == SMC_SERV || key->clcqpn == lnkc->clcqpn) &&
> +	    (key->smcr_version == SMC_V2 ||
> +	    !memcmp(key->peer_mac, lnkc->peer_mac, ETH_ALEN)))
> +		return 0;
> +
> +	return 1;
> +}
> +
> +/* SMC-R lnk cluster hash func */
> +static u32 smcr_lnk_cluster_hashfn(const void *data, u32 len, u32 seed)
> +{
> +	const struct smc_lnk_cluster *lnkc = data;
> +
> +	return jhash2((u32 *)lnkc->peer_systemid, SMC_SYSTEMID_LEN / sizeof(u32), seed)
> +		+ (lnkc->role == SMC_SERV) ? 0 : lnkc->clcqpn;
> +}
> +
> +/* SMC-R lnk cluster compare arg hash func */
> +static u32 smcr_lnk_cluster_compare_arg_hashfn(const void *data, u32 len, u32 seed)
> +{
> +	const struct smc_lnk_cluster_compare_arg *key = data;
> +
> +	return jhash2((u32 *)key->peer_systemid, SMC_SYSTEMID_LEN / sizeof(u32), seed)
> +		+ (key->role == SMC_SERV) ? 0 : key->clcqpn;
> +}
> +
> +static const struct rhashtable_params smcr_lnk_cluster_rhl_params = {
> +	.head_offset = offsetof(struct smc_lnk_cluster, rnode),
> +	.key_len = sizeof(struct smc_lnk_cluster_compare_arg),
> +	.obj_cmpfn = smcr_lnk_cluster_cmpfn,
> +	.obj_hashfn = smcr_lnk_cluster_hashfn,
> +	.hashfn = smcr_lnk_cluster_compare_arg_hashfn,
> +	.automatic_shrinking = true,
> +};
> +
> +/* hold a reference for smc_lnk_cluster */
> +static inline void smc_lnk_cluster_hold(struct smc_lnk_cluster *lnkc)
> +{
> +	if (likely(lnkc))
> +		refcount_inc(&lnkc->ref);
> +}
> +
> +/* release a reference for smc_lnk_cluster */
> +static inline void smc_lnk_cluster_put(struct smc_lnk_cluster *lnkc)
> +{
> +	bool do_free = false;
> +
> +	if (!lnkc)
> +		return;
> +
> +	if (refcount_dec_not_one(&lnkc->ref))
> +		return;
> +
> +	spin_lock_bh(&smc_lgr_manager.lock);
> +	/* last ref */
> +	if (refcount_dec_and_test(&lnkc->ref)) {
> +		do_free = true;
> +		rhashtable_remove_fast(&smc_lgr_manager.lnk_cluster_maps, &lnkc->rnode,
> +				       smcr_lnk_cluster_rhl_params);
> +	}
> +	spin_unlock_bh(&smc_lgr_manager.lock);
> +	if (do_free)
> +		kfree(lnkc);
> +}
> +
> +/* Get or create smc_lnk_cluster by key
> + * This function will hold a reference of returned smc_lnk_cluster
> + * or create a new smc_lnk_cluster with the reference initialized to 1。
> + * caller MUST call smc_lnk_cluster_put after this.
> + */
> +static inline struct smc_lnk_cluster *
> +smcr_lnk_get_or_create_cluster(struct smc_lnk_cluster_compare_arg *key)
> +{
> +	struct smc_lnk_cluster *lnkc, *tmp_lnkc;
> +	bool busy_retry;
> +	int err;
> +
> +	/* serving a hardware or software interrupt, or preemption is disabled */
> +	busy_retry = !in_interrupt();
> +
> +	spin_lock_bh(&smc_lgr_manager.lock);
> +	lnkc = rhashtable_lookup_fast(&smc_lgr_manager.lnk_cluster_maps, key,
> +				      smcr_lnk_cluster_rhl_params);
> +	if (!lnkc) {
> +		lnkc = kzalloc(sizeof(*lnkc), GFP_ATOMIC);
> +		if (unlikely(!lnkc))
> +			goto fail;
> +
> +		/* init cluster */
> +		spin_lock_init(&lnkc->lock);
> +		lnkc->role = key->role;
> +		if (key->role == SMC_CLNT)
> +			lnkc->clcqpn = key->clcqpn;
> +		init_waitqueue_head(&lnkc->first_contact_waitqueue);
> +		memcpy(lnkc->peer_systemid, key->peer_systemid, SMC_SYSTEMID_LEN);
> +		memcpy(lnkc->peer_gid, key->peer_gid, SMC_GID_SIZE);
> +		memcpy(lnkc->peer_mac, key->peer_mac, ETH_ALEN);
> +		refcount_set(&lnkc->ref, 1);
> +
> +		do {
> +			err = rhashtable_insert_fast(&smc_lgr_manager.lnk_cluster_maps,
> +						     &lnkc->rnode, smcr_lnk_cluster_rhl_params);
> +
> +			/* success or fatal error */
> +			if (err != -EBUSY)
> +				break;
> +
> +			/* impossible in fact right now */
> +			if (unlikely(!busy_retry)) {
> +				pr_warn_ratelimited("smc: create lnk cluster in softirq\n");
> +				break;
> +			}
> +
> +			spin_unlock_bh(&smc_lgr_manager.lock);
> +			/* yeild */
> +			cond_resched();
> +			spin_lock_bh(&smc_lgr_manager.lock);
> +
> +			/* after spin_unlock_bh(), lnk_cluster_maps may be changed */
> +			tmp_lnkc = rhashtable_lookup_fast(&smc_lgr_manager.lnk_cluster_maps, key,
> +							  smcr_lnk_cluster_rhl_params);
> +
> +			if (unlikely(tmp_lnkc)) {
> +				pr_warn_ratelimited("smc: create cluster failed dues to duplicat key");
> +				kfree(lnkc);
> +				lnkc = NULL;
> +				goto fail;
> +			}
> +		} while (1);
> +
> +		if (unlikely(err)) {
> +			pr_warn_ratelimited("smc: rhashtable_insert_fast failed (%d)", err);
> +			kfree(lnkc);
> +			lnkc = NULL;
> +		}
> +	} else {
> +		smc_lnk_cluster_hold(lnkc);
> +	}
> +fail:
> +	spin_unlock_bh(&smc_lgr_manager.lock);
> +	return lnkc;
> +}
> +
> +/* Get or create a smc_lnk_cluster by lnk
> + * caller MUST call smc_lnk_cluster_put after this.
> + */
> +static inline struct smc_lnk_cluster *smcr_lnk_get_cluster(struct smc_link *lnk)
> +{
> +	struct smc_lnk_cluster_compare_arg key;
> +	struct smc_link_group *lgr;
> +
> +	lgr = lnk->lgr;
> +	if (!lgr || lgr->is_smcd)
> +		return NULL;
> +
> +	key.smcr_version = lgr->smc_version;
> +	key.peer_systemid = lgr->peer_systemid;
> +	key.peer_gid = lnk->peer_gid;
> +	key.peer_mac = lnk->peer_mac;
> +	key.role	 = lgr->role;
> +	if (key.role == SMC_CLNT)
> +		key.clcqpn = lnk->peer_qpn;
> +
> +	return smcr_lnk_get_or_create_cluster(&key);
> +}
> +
> +/* Get or create a smc_lnk_cluster by ini
> + * caller MUST call smc_lnk_cluster_put after this.
> + */
> +static inline struct smc_lnk_cluster *
> +smcr_lnk_get_cluster_by_ini(struct smc_init_info *ini, int role)
> +{
> +	struct smc_lnk_cluster_compare_arg key;
> +
> +	if (ini->is_smcd)
> +		return NULL;
> +
> +	key.smcr_version = ini->smcr_version;
> +	key.peer_systemid = ini->peer_systemid;
> +	key.peer_gid = ini->peer_gid;
> +	key.peer_mac = ini->peer_mac;
> +	key.role	= role;
> +	if (role == SMC_CLNT)
> +		key.clcqpn	= ini->ib_clcqpn;
> +
> +	return smcr_lnk_get_or_create_cluster(&key);
> +}
> +
> +/* callback when smc link state change */
> +void smcr_lnk_cluster_on_lnk_state(struct smc_link *lnk)
> +{
> +	struct smc_lnk_cluster *lnkc;
> +	int nr = 0;
> +
> +	/* barrier for lnk->state */
> +	smp_mb();
> +
> +	/* only first link can made connections block on
> +	 * first_contact_waitqueue
> +	 */
> +	if (lnk->link_idx != SMC_SINGLE_LINK)
> +		return;
> +
> +	/* state already seen  */
> +	if (lnk->state_record & SMC_LNK_STATE_BIT(lnk->state))
> +		return;
> +
> +	lnkc = smcr_lnk_get_cluster(lnk);
> +
> +	if (unlikely(!lnkc))
> +		return;
> +
> +	spin_lock_bh(&lnkc->lock);
> +
> +	/* all lnk state change should be
> +	 * 1. SMC_LNK_UNUSED -> SMC_LNK_TEAR_DWON (link init failed)

Should this really be DWON and not DOWN?

> +	 * 2. SMC_LNK_UNUSED -> SMC_LNK_ACTIVATING -> SMC_LNK_TEAR_DWON
> +	 * 3. SMC_LNK_UNUSED -> SMC_LNK_ACTIVATING -> SMC_LNK_INACTIVE -> SMC_LNK_TEAR_DWON
> +	 * 4. SMC_LNK_UNUSED -> SMC_LNK_ACTIVATING -> SMC_LNK_INACTIVE -> SMC_LNK_TEAR_DWON
> +	 * 5. SMC_LNK_UNUSED -> SMC_LNK_ATIVATING -> SMC_LNK_ACTIVE ->SMC_LNK_INACTIVE
> +	 * -> SMC_LNK_TEAR_DWON
> +	 */
> +	switch (lnk->state) {
> +	case SMC_LNK_ACTIVATING:
> +		/* It's safe to hold a reference without lock
> +		 * dues to the smcr_lnk_get_cluster already hold one
> +		 */
> +		smc_lnk_cluster_hold(lnkc);
> +		break;
> +	case SMC_LNK_TEAR_DWON:
> +		if (lnk->state_record & SMC_LNK_STATE_BIT(SMC_LNK_ACTIVATING))
> +			/* smc_lnk_cluster_hold in SMC_LNK_ACTIVATING */
> +			smc_lnk_cluster_put(lnkc);
> +		fallthrough;
> +	case SMC_LNK_ACTIVE:
> +	case SMC_LNK_INACTIVE:
> +		if (!(lnk->state_record &
> +			(SMC_LNK_STATE_BIT(SMC_LNK_ACTIVE)
> +			| SMC_LNK_STATE_BIT(SMC_LNK_INACTIVE)))) {
> +			lnkc->pending_capability -= (SMC_RMBS_PER_LGR_MAX - 1);
> +			/* TODO: wakeup just one to perfrom first contact
> +			 * if record state has no SMC_LNK_ACTIVE
> +			 */


Todo in a patch.

> +			nr = SMC_RMBS_PER_LGR_MAX - 1;
> +		}
> +		break;
> +	case SMC_LNK_UNUSED:
> +		pr_warn_ratelimited("net/smc: invalid lnk state. ");
> +		break;
> +	}
> +	SMC_LNK_STATE_RECORD(lnk, lnk->state);
> +	spin_unlock_bh(&lnkc->lock);
> +	if (nr)
> +		wake_up_nr(&lnkc->first_contact_waitqueue, nr);
> +	smc_lnk_cluster_put(lnkc);	/* smc_lnk_cluster_hold in smcr_lnk_get_cluster */
> +}
> +
>   /* return head of link group list and its lock for a given link group */
>   static inline struct list_head *smc_lgr_list_head(struct smc_link_group *lgr,
>   						  spinlock_t **lgr_lock)
> @@ -651,8 +931,10 @@ static void smcr_lgr_link_deactivate_all(struct smc_link_group *lgr)
>   	for (i = 0; i < SMC_LINKS_PER_LGR_MAX; i++) {
>   		struct smc_link *lnk = &lgr->lnk[i];
> 
> -		if (smc_link_sendable(lnk))
> +		if (smc_link_sendable(lnk)) {
>   			lnk->state = SMC_LNK_INACTIVE;
> +			smcr_lnk_cluster_on_lnk_state(lnk);
> +		}
>   	}
>   	wake_up_all(&lgr->llc_msg_waiter);
>   	wake_up_all(&lgr->llc_flow_waiter);
> @@ -762,6 +1044,9 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
>   	atomic_set(&lnk->conn_cnt, 0);
>   	smc_llc_link_set_uid(lnk);
>   	INIT_WORK(&lnk->link_down_wrk, smc_link_down_work);
> +	lnk->peer_qpn = ini->ib_clcqpn;
> +	memcpy(lnk->peer_gid, ini->peer_gid, SMC_GID_SIZE);
> +	memcpy(lnk->peer_mac, ini->peer_mac, sizeof(lnk->peer_mac));
>   	if (!lnk->smcibdev->initialized) {
>   		rc = (int)smc_ib_setup_per_ibdev(lnk->smcibdev);
>   		if (rc)
> @@ -792,6 +1077,7 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
>   	if (rc)
>   		goto destroy_qp;
>   	lnk->state = SMC_LNK_ACTIVATING;
> +	smcr_lnk_cluster_on_lnk_state(lnk);
>   	return 0;
> 
>   destroy_qp:
> @@ -806,6 +1092,8 @@ int smcr_link_init(struct smc_link_group *lgr, struct smc_link *lnk,
>   	smc_ibdev_cnt_dec(lnk);
>   	put_device(&lnk->smcibdev->ibdev->dev);
>   	smcibdev = lnk->smcibdev;
> +	lnk->state = SMC_LNK_TEAR_DWON;
> +	smcr_lnk_cluster_on_lnk_state(lnk);
>   	memset(lnk, 0, sizeof(struct smc_link));
>   	lnk->state = SMC_LNK_UNUSED;
>   	if (!atomic_dec_return(&smcibdev->lnk_cnt))
> @@ -1263,6 +1551,8 @@ void smcr_link_clear(struct smc_link *lnk, bool log)
>   	if (!lnk->lgr || lnk->clearing ||
>   	    lnk->state == SMC_LNK_UNUSED)
>   		return;
> +	lnk->state = SMC_LNK_TEAR_DWON;
> +	smcr_lnk_cluster_on_lnk_state(lnk);
>   	lnk->clearing = 1;
>   	lnk->peer_qpn = 0;
>   	smc_llc_link_clear(lnk, log);
> @@ -1712,6 +2002,7 @@ void smcr_link_down_cond(struct smc_link *lnk)
>   {
>   	if (smc_link_downing(&lnk->state)) {
>   		trace_smcr_link_down(lnk, __builtin_return_address(0));
> +		smcr_lnk_cluster_on_lnk_state(lnk);
>   		smcr_link_down(lnk);
>   	}
>   }
> @@ -1721,6 +2012,7 @@ void smcr_link_down_cond_sched(struct smc_link *lnk)
>   {
>   	if (smc_link_downing(&lnk->state)) {
>   		trace_smcr_link_down(lnk, __builtin_return_address(0));
> +		smcr_lnk_cluster_on_lnk_state(lnk);
>   		schedule_work(&lnk->link_down_wrk);
>   	}
>   }
> @@ -1850,11 +2142,13 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
>   {
>   	struct smc_connection *conn = &smc->conn;
>   	struct net *net = sock_net(&smc->sk);
> +	DECLARE_WAITQUEUE(wait, current);
> +	struct smc_lnk_cluster *lnkc = NULL;

Declared as NULL.

>   	struct list_head *lgr_list;
>   	struct smc_link_group *lgr;
>   	enum smc_lgr_role role;
>   	spinlock_t *lgr_lock;
> -	int rc = 0;
> +	int rc = 0, timeo = CLC_WAIT_TIME;
> 
>   	lgr_list = ini->is_smcd ? &ini->ism_dev[ini->ism_selected]->lgr_list :
>   				  &smc_lgr_list.list;
> @@ -1862,12 +2156,26 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
>   				  &smc_lgr_list.lock;
>   	ini->first_contact_local = 1;
>   	role = smc->listen_smc ? SMC_SERV : SMC_CLNT;
> -	if (role == SMC_CLNT && ini->first_contact_peer)
> +
> +	if (!ini->is_smcd) {
> +		lnkc = smcr_lnk_get_cluster_by_ini(ini, role);

Here linkc is set if it is SMC-R.

> +		if (unlikely(!lnkc))
> +			return SMC_CLC_DECL_INTERR;
> +	}
> +
> +	if (role == SMC_CLNT && ini->first_contact_peer) {
> +		/* first_contact */
> +		spin_lock_bh(&lnkc->lock);

And here SMC-D dies because of the NULL address. This kills our Systems 
if we try to talk via SMC-D.

[  779.516389] Failing address: 0000000000000000 TEID: 0000000000000483
[  779.516391] Fault in home space mode while using kernel ASCE.
[  779.516395] AS:0000000069628007 R3:00000000ffbf0007 
S:00000000ffbef800 P:000000000000003d
[  779.516431] Oops: 0004 ilc:2 [#1] SMP
[  779.516436] Modules linked in: tcp_diag inet_diag ism mlx5_ib 
ib_uverbs mlx5_core smc_diag smc ib_core nft_fib_inet nft_fib_ipv4
nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 
nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv
6 nf_defrag_ipv4 ip_set nf_tables n
[  779.516470] CPU: 0 PID: 24 Comm: kworker/0:1 Not tainted 
5.19.0-13940-g22a46254655a #3
[  779.516476] Hardware name: IBM 8561 T01 701 (z/VM 7.2.0)

[  779.522738] Workqueue: smc_hs_wq smc_listen_work [smc]
[  779.522755] Krnl PSW : 0704c00180000000 000003ff803da89c 
(smc_conn_create+0x174/0x968 [smc])
[  779.522766]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 
PM:0 RI:0 EA:3
[  779.522770] Krnl GPRS: 0000000000000002 0000000000000000 
0000000000000001 0000000000000000
[  779.522773]            000000008a4128a0 000003ff803f21aa 
000000008e30d640 0000000086d72000
[  779.522776]            0000000086d72000 000000008a412803 
000000008a412800 000000008e30d650
[  779.522779]            0000000080934200 0000000000000000 
000003ff803cb954 00000380002dfa88
[  779.522789] Krnl Code: 000003ff803da88e: e310f0e80024        stg 
%r1,232(%r15)
[  779.522789]            000003ff803da894: a7180000            lhi %r1,0
[  779.522789]           #000003ff803da898: 582003ac            l %r2,940
[  779.522789]           >000003ff803da89c: ba123020            cs 
%r1,%r2,32(%r3)
[  779.522789]            000003ff803da8a0: ec1603be007e        cij 
%r1,0,6,000003ff803db01c

[  779.522789]            000003ff803da8a6: 4110b002            la 
%r1,2(%r11)
[  779.522789]            000003ff803da8aa: e310f0f00024        stg 
%r1,240(%r15)
[  779.522789]            000003ff803da8b0: e310f0c00004        lg 
%r1,192(%r15)
[  779.522870] Call Trace:
[  779.522873]  [<000003ff803da89c>] smc_conn_create+0x174/0x968 [smc]
[  779.522884]  [<000003ff803cb954>] 
smc_find_ism_v2_device_serv+0x1b4/0x300 [smc]

> +		lnkc->pending_capability += (SMC_RMBS_PER_LGR_MAX - 1);
> +		spin_unlock_bh(&lnkc->lock);
>   		/* create new link group as well */
>   		goto create;
> +	}
> 
>   	/* determine if an existing link group can be reused */
>   	spin_lock_bh(lgr_lock);
> +	spin_lock(&lnkc->lock);
> +again:
>   	list_for_each_entry(lgr, lgr_list, list) {
>   		write_lock_bh(&lgr->conns_lock);
>   		if ((ini->is_smcd ?
> @@ -1894,9 +2202,33 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
>   		}
>   		write_unlock_bh(&lgr->conns_lock);
>   	}
> +	if (lnkc && ini->first_contact_local) {
> +		if (lnkc->pending_capability > lnkc->conns_pending) {
> +			lnkc->conns_pending++;
> +			add_wait_queue(&lnkc->first_contact_waitqueue, &wait);
> +			spin_unlock(&lnkc->lock);
> +			spin_unlock_bh(lgr_lock);
> +			set_current_state(TASK_INTERRUPTIBLE);
> +			/* need to wait at least once first contact done */
> +			timeo = schedule_timeout(timeo);
> +			set_current_state(TASK_RUNNING);
> +			remove_wait_queue(&lnkc->first_contact_waitqueue, &wait);
> +			spin_lock_bh(lgr_lock);
> +			spin_lock(&lnkc->lock);
> +
> +			lnkc->conns_pending--;
> +			if (timeo)
> +				goto again;
> +		}
> +		if (role == SMC_SERV) {
> +			/* first_contact */
> +			lnkc->pending_capability += (SMC_RMBS_PER_LGR_MAX - 1);
> +		}
> +	}
> +	spin_unlock(&lnkc->lock);
>   	spin_unlock_bh(lgr_lock);
>   	if (rc)
> -		return rc;
> +		goto out;
> 
>   	if (role == SMC_CLNT && !ini->first_contact_peer &&
>   	    ini->first_contact_local) {
> @@ -1904,7 +2236,8 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
>   		 * a new one
>   		 * send out_of_sync decline, reason synchr. error
>   		 */
> -		return SMC_CLC_DECL_SYNCERR;
> +		rc = SMC_CLC_DECL_SYNCERR;
> +		goto out;
>   	}
> 
>   create:
> @@ -1941,6 +2274,8 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
>   #endif
> 
>   out:
> +	/* smc_lnk_cluster_hold in smcr_lnk_get_or_create_cluster */
> +	smc_lnk_cluster_put(lnkc);
>   	return rc;
>   }
> 
> @@ -2599,12 +2934,23 @@ static int smc_core_reboot_event(struct notifier_block *this,
> 
>   int __init smc_core_init(void)
>   {
> +	/* init smc lnk cluster maps */
> +	rhashtable_init(&smc_lgr_manager.lnk_cluster_maps, &smcr_lnk_cluster_rhl_params);
>   	return register_reboot_notifier(&smc_reboot_notifier);
>   }
> 
> +static void smc_lnk_cluster_free_cb(void *ptr, void *arg)
> +{
> +	pr_warn("smc: smc lnk cluster refcnt leak.\n");
> +	kfree(ptr);
> +}
> +
>   /* Called (from smc_exit) when module is removed */
>   void smc_core_exit(void)
>   {
>   	unregister_reboot_notifier(&smc_reboot_notifier);
>   	smc_lgrs_shutdown();
> +	/* destroy smc lnk cluster maps */
> +	rhashtable_free_and_destroy(&smc_lgr_manager.lnk_cluster_maps, smc_lnk_cluster_free_cb,
> +				    NULL);
>   }
> diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
> index fe8b524..199f533 100644
> --- a/net/smc/smc_core.h
> +++ b/net/smc/smc_core.h
> @@ -15,6 +15,7 @@
>   #include <linux/atomic.h>
>   #include <linux/smc.h>
>   #include <linux/pci.h>
> +#include <linux/rhashtable.h>
>   #include <rdma/ib_verbs.h>
>   #include <net/genetlink.h>
> 
> @@ -29,18 +30,62 @@ struct smc_lgr_list {			/* list of link group definition */
>   	u32			num;	/* unique link group number */
>   };
> 
> +struct smc_lgr_manager {		/* manager for link group */
> +	struct rhashtable	lnk_cluster_maps;	/* maps of smc_lnk_cluster */
> +	spinlock_t		lock;	/* lock for lgr_cm_maps */
> +};
> +
> +struct smc_lnk_cluster {
> +	struct rhash_head	rnode;	/* node for rhashtable */
> +	struct wait_queue_head	first_contact_waitqueue;
> +					/* queue for non first contact to wait
> +					 * first contact to be established.
> +					 */
> +	spinlock_t		lock;	/* protection for link group */
> +	refcount_t		ref;	/* refcount for cluster */
> +	unsigned long		pending_capability;
> +					/* maximum pending number of connections that
> +					 * need wait first contact complete.
> +					 */
> +	unsigned long		conns_pending;
> +					/* connections that are waiting for first contact
> +					 * complete
> +					 */
> +	u8		peer_systemid[SMC_SYSTEMID_LEN];
> +	u8		peer_mac[ETH_ALEN];	/* = gid[8:10||13:15] */
> +	u8		peer_gid[SMC_GID_SIZE];	/* gid of peer*/
> +	int		clcqpn;
> +	int		role;
> +};
> +
>   enum smc_lgr_role {		/* possible roles of a link group */
>   	SMC_CLNT,	/* client */
>   	SMC_SERV	/* server */
>   };
> 
> +struct smc_lnk_cluster_compare_arg	/* key for smc_lnk_cluster */
> +{
> +	int	smcr_version;
> +	enum smc_lgr_role role;
> +	u8	*peer_systemid;
> +	u8	*peer_gid;
> +	u8	*peer_mac;
> +	int clcqpn;
> +};
> +
>   enum smc_link_state {			/* possible states of a link */
>   	SMC_LNK_UNUSED,		/* link is unused */
>   	SMC_LNK_INACTIVE,	/* link is inactive */
>   	SMC_LNK_ACTIVATING,	/* link is being activated */
>   	SMC_LNK_ACTIVE,		/* link is active */
> +	SMC_LNK_TEAR_DWON,	/* link is tear down */
>   };
> 
> +#define SMC_LNK_STATE_BIT(state)	(1 << (state))
> +
> +#define	SMC_LNK_STATE_RECORD(lnk, state)	\
> +	((lnk)->state_record |= SMC_LNK_STATE_BIT(state))
> +
>   #define SMC_WR_BUF_SIZE		48	/* size of work request buffer */
>   #define SMC_WR_BUF_V2_SIZE	8192	/* size of v2 work request buffer */
> 
> @@ -145,6 +190,7 @@ struct smc_link {
>   	int			ndev_ifidx; /* network device ifindex */
> 
>   	enum smc_link_state	state;		/* state of link */
> +	int			state_record;		/* record of previous state */
>   	struct delayed_work	llc_testlink_wrk; /* testlink worker */
>   	struct completion	llc_testlink_resp; /* wait for rx of testlink */
>   	int			llc_testlink_time; /* testlink interval */
> @@ -557,6 +603,8 @@ struct smc_link *smc_switch_conns(struct smc_link_group *lgr,
>   int smcr_nl_get_link(struct sk_buff *skb, struct netlink_callback *cb);
>   int smcd_nl_get_lgr(struct sk_buff *skb, struct netlink_callback *cb);
> 
> +void smcr_lnk_cluster_on_lnk_state(struct smc_link *lnk);
> +
>   static inline struct smc_link_group *smc_get_lgr(struct smc_link *link)
>   {
>   	return link->lgr;
> diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
> index 175026a..8134c15 100644
> --- a/net/smc/smc_llc.c
> +++ b/net/smc/smc_llc.c
> @@ -1099,6 +1099,7 @@ int smc_llc_cli_add_link(struct smc_link *link, struct smc_llc_qentry *qentry)
>   		goto out;
>   out_clear_lnk:
>   	lnk_new->state = SMC_LNK_INACTIVE;
> +	smcr_lnk_cluster_on_lnk_state(lnk_new);
>   	smcr_link_clear(lnk_new, false);
>   out_reject:
>   	smc_llc_cli_add_link_reject(qentry);
> @@ -1278,6 +1279,7 @@ static void smc_llc_delete_asym_link(struct smc_link_group *lgr)
>   		return; /* no asymmetric link */
>   	if (!smc_link_downing(&lnk_asym->state))
>   		return;
> +	smcr_lnk_cluster_on_lnk_state(lnk_asym);
>   	lnk_new = smc_switch_conns(lgr, lnk_asym, false);
>   	smc_wr_tx_wait_no_pending_sends(lnk_asym);
>   	if (!lnk_new)
> @@ -1492,6 +1494,7 @@ int smc_llc_srv_add_link(struct smc_link *link,
>   out_err:
>   	if (link_new) {
>   		link_new->state = SMC_LNK_INACTIVE;
> +		smcr_lnk_cluster_on_lnk_state(link_new);
>   		smcr_link_clear(link_new, false);
>   	}
>   out:
> @@ -1602,8 +1605,10 @@ static void smc_llc_process_cli_delete_link(struct smc_link_group *lgr)
>   	del_llc->reason = 0;
>   	smc_llc_send_message(lnk, &qentry->msg); /* response */
> 
> -	if (smc_link_downing(&lnk_del->state))
> +	if (smc_link_downing(&lnk_del->state)) {
> +		smcr_lnk_cluster_on_lnk_state(lnk);
>   		smc_switch_conns(lgr, lnk_del, false);
> +	}
>   	smcr_link_clear(lnk_del, true);
> 
>   	active_links = smc_llc_active_link_count(lgr);
> @@ -1676,6 +1681,7 @@ static void smc_llc_process_srv_delete_link(struct smc_link_group *lgr)
>   		goto out; /* asymmetric link already deleted */
> 
>   	if (smc_link_downing(&lnk_del->state)) {
> +		smcr_lnk_cluster_on_lnk_state(lnk);
>   		if (smc_switch_conns(lgr, lnk_del, false))
>   			smc_wr_tx_wait_no_pending_sends(lnk_del);
>   	}
> @@ -2167,6 +2173,7 @@ void smc_llc_link_active(struct smc_link *link)
>   		schedule_delayed_work(&link->llc_testlink_wrk,
>   				      link->llc_testlink_time);
>   	}
> +	smcr_lnk_cluster_on_lnk_state(link);
>   }
> 
>   /* called in worker context */
