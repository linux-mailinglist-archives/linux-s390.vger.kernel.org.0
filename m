Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E38B637B12
	for <lists+linux-s390@lfdr.de>; Thu, 24 Nov 2022 15:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiKXOHT (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 24 Nov 2022 09:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiKXOHS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 24 Nov 2022 09:07:18 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA74428E3D;
        Thu, 24 Nov 2022 06:07:16 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AOCWn37029301;
        Thu, 24 Nov 2022 14:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=AlheZ9vgyGJ16teHD6ng4yV/5mBzcs6LQNSf3/4gFH4=;
 b=fKH4RtmbqReQGk5o1xIjl3vTgjkxO1cJPFuMZKPF3t2s7jKBEgHOoPF9wCQpzlf26ku6
 oehY3za1Zj7l89UJi7g3jI8lFzuNXKKqAcw/I42C9lj23NUvbp7PzSh2a860ltJbSZ0q
 zi5/RZe8NKR/PeoTNSsVPDGLlLHL14V6VbCyglXVBl+5cgMBbrgV4l+c6w+S+rDaDvC0
 Qb4I+m1JGUffIf1cpMeTi6v+QDhRDHYQHi2NYEUAB887ekGErex+M7HTRLNYmW55HKog
 30rSMdCZiRvyzJuGJqiNTZn3UfVpxkx4Sdc4VJveKyKzjipnOm3SULm+67p9Ih+casbV RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m10fgpe4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Nov 2022 14:07:13 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AODsm4W029838;
        Thu, 24 Nov 2022 14:07:12 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m10fgpe2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Nov 2022 14:07:12 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AOE5oLk025761;
        Thu, 24 Nov 2022 14:07:09 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3kxps9608f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Nov 2022 14:07:09 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AOE7l8V5047000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Nov 2022 14:07:47 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E58F75204E;
        Thu, 24 Nov 2022 14:07:05 +0000 (GMT)
Received: from [9.152.224.55] (unknown [9.152.224.55])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8DF6752050;
        Thu, 24 Nov 2022 14:07:05 +0000 (GMT)
Message-ID: <1a36b6ba-e7bb-6f2a-c460-cf158cb64b1d@linux.ibm.com>
Date:   Thu, 24 Nov 2022 15:07:05 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH net] net/smc: Fix expected buffersizes and sync logic
Content-Language: en-US
From:   Alexandra Winter <wintera@linux.ibm.com>
To:     Tony Lu <tonylu@linux.alibaba.com>,
        Jan Karcher <jaka@linux.ibm.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>
References: <20221123104907.14624-1-jaka@linux.ibm.com>
 <Y34JxFWBdUxvLQb4@TonyMac-Alibaba>
 <40428548-59b9-379c-857c-172db92afc0c@linux.ibm.com>
 <Y34i8nmJIeIiFuOP@TonyMac-Alibaba>
 <f5237afd-d57b-f317-4263-31b4bb3d0d17@linux.ibm.com>
In-Reply-To: <f5237afd-d57b-f317-4263-31b4bb3d0d17@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KcV1zNEE0dxhvVNtwlyaLwCl9x3BqMtC
X-Proofpoint-GUID: 4rnwhmg20Y4LI1v2VJ5WZthCdkJSxUjt
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-24_11,2022-11-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211240106
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 24.11.22 14:00, Alexandra Winter wrote:
> 
> 
> On 23.11.22 14:41, Tony Lu wrote:
>> On Wed, Nov 23, 2022 at 02:13:04PM +0100, Jan Karcher wrote:
>>>
>>>
>>> On 23/11/2022 12:53, Tony Lu wrote:
>>>> On Wed, Nov 23, 2022 at 11:49:07AM +0100, Jan Karcher wrote:
>>>>> The fixed commit changed the expected behavior of buffersizes
>>>>> set by the user using the setsockopt mechanism.
>>>>> Before the fixed patch the logic for determining the buffersizes used
>>>>> was the following:
>>>>>
>>>>> default  = net.ipv4.tcp_{w|r}mem[1]
Jan, you explained to me: "the minima is 16Kib. This is enforced in smc_compress_bufsize 
which would move any value <= 16Kib into bucket 0 - which is 16KiB "
net.ipv4.tcp_wmem[1] defaults to 8Kib. So in the default case (unchanged net.ipv4.tcp_wmem[1])
the default for the send path is not net.ipv4.tcp_wmem[1]. Should be clarified here.
>>>>> sockopt  = the setsockopt mechanism
>>>>> val      = the value assigned in default or via setsockopt
>>>>> sk_buf   = short for sk_{snd|rcv}buf
>>>>> real_buf = the real size of the buffer (sk_buf_size in __smc_buf_create)
>>>>>
>>>>>    exposed   | net/core/sock.c  |    af_smc.c    |  smc_core.c
>>>>>              |                  |                |
>>>>> +---------+ |                  | +------------+ | +-------------------+
>>>>> | default |----------------------| sk_buf=val |---| real_buf=sk_buf/2 |
>>>>> +---------+ |                  | +------------+ | +-------------------+
>>>>>              |                  |                |    ^
>>>>>              |                  |                |    |
>>>>> +---------+ | +--------------+ |                |    |
>>>>> | sockopt |---| sk_buf=val*2 |-----------------------|
>>>>> +---------+ | +--------------+ |                |
>>>>>              |                  |                |
>>>>>
>>>>> The fixed patch introduced a dedicated sysctl for smc
>>>>> and removed the /2 in smc_core.c resulting in the following flow:
>>>>>
>>>>> default  = net.smc.{w|r}mem (which defaults to net.ipv4.tcp_{w|r}mem[1])
>>>>> sockopt  = the setsockopt mechanism
>>>>> val      = the value assigned in default or via setsockopt
>>>>> sk_buf   = short for sk_{snd|rcv}buf
>>>>> real_buf = the real size of the buffer (sk_buf_size in __smc_buf_create)
>>>>>
>>>>>    exposed   | net/core/sock.c  |    af_smc.c    |  smc_core.c
>>>>>              |                  |                |
>>>>> +---------+ |                  | +------------+ | +-----------------+
>>>>> | default |----------------------| sk_buf=val |---| real_buf=sk_buf |
>>>>> +---------+ |                  | +------------+ | +-----------------+
>>>>>              |                  |                |    ^
>>>>>              |                  |                |    |
>>>>> +---------+ | +--------------+ |                |    |
>>>>> | sockopt |---| sk_buf=val*2 |-----------------------|
>>>>> +---------+ | +--------------+ |                |
>>>>>              |                  |                |
>>>>>
>>>>> This would result in double of memory used for existing configurations
>>>>> that are using setsockopt.
>>>>
>>>> Firstly, thanks for your detailed diagrams :-)
>>>>
>>>> And the original decision to use user-provided values rather than
>>>> value/2 to follow the instructions of the socket manual [1].
>>>>
>>>>    SO_RCVBUF
>>>>           Sets or gets the maximum socket receive buffer in bytes.
>>>>           The kernel doubles this value (to allow space for
>>>>           bookkeeping overhead) when it is set using setsockopt(2),
>>>>           and this doubled value is returned by getsockopt(2).  The
>>>>           default value is set by the
>>>>           /proc/sys/net/core/rmem_default file, and the maximum
>>>>           allowed value is set by the /proc/sys/net/core/rmem_max
>>>>           file.  The minimum (doubled) value for this option is 256.
>>>>
>>>> [1] https://man7.org/linux/man-pages/man7/socket.7.html
>>>>
>>>> The user of SMC should know that setsockopt() with SO_{RCV|SND}BUF will
>>>
>>> I totally agree that an educated user of SMC should know about that behavior
>>> if they decide to use it.
>>> We do provide our users preload libraries where they can pass preferred
>>> buffersizes via arguments and we handle the Sockopts for them.
>>>
>>>> double the values in kernel, and getsockopt() will return the doubled
>>>> values. So that they should use half of the values which are passed to
>>>> setsockopt(). The original patch tries to make things easier in SMC and
>>>> let user-space to handle them following the socket manual.
>>>>
>>>>> SMC historically decided to use the explicit value given by the user
>>>>> to allocate the memory. This is why we used the /2 in smc_core.c.
>>>>> That logic was not applied to the default value.
>>>>
>>>> Yep, let back to the patch which introduced smc_{w|r}mem knobs, it's a
>>>> trade-off to follow original logic of SMC, or follow the socket manual.
>>>> We decides to follow the instruction of manuals in the end.
>>>
>>> I understand the point. I spend a lot of time trying to decide what to do.
>>>
>>> Since it was an intentional decision to not follow the general socket
>>> option, and we do not have anyone complaining we do not really have a reason
>>> to change it.
>>> Changing it means that users with existing configurations would have to
>>> change their configs on an update or suddenly expect double the memory
>>> consumption.
>>> That's why we in the end preffered to stay with the current logic.
>>
>> I can't agree with you more with the points to follow the historic logic
>> and not break the user-space applications.
>>
>>> I'm thinking that maybe - if we stay with the historic logic - we should
>>> document that desicion somewhere. So that in the future, if a user that
>>> expects the man page behavior, has a way to understand what SMC is doing.
>>> What do oyu think?
>>
>> Yep, we _really_ need to document it if we change the convention.
>> Actually, I spent a lot of time to find the history about the logic of
>> buffer (/2 and *2) in SMC. So I'm really in favor of adding
>> documentation, at least code comments to help others to understand them.
>>
>> Cheers,
>> Tony Lu
> Iiuc you are changing the default values in this a patch and your other patch:
> Default values for real_buf for send and receive:
> 
> before 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock and make them tunable")
>     real_buf=net.ipv4.tcp_{w|r}mem[1]/2   send: 8k  recv: 64k 
      see above: 			    send: 16k recv: 64k
>     
> after 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock and make them tunable")
> real_buf=net.ipv4.tcp_{w|r}mem[1]   send: 16k (16*1024) recv: 128k (131072) 
> 
> after net/smc: Fix expected buffersizes and sync logic
> real_buf=net.ipv4.tcp_{w|r}mem[1]   send: 16k (16*1024) recv: 128k (131072) 
> 
> after net/smc: Unbind smc control from tcp control
> real_buf=SMC_*BUF_INIT_SIZE   send: 16k (16384) recv: 64k (65536)
> 
> If my understanding is correct, then I nack this. 
> Defaults should be restored to the values before 0227f058aa29.
> Otherwise users will notice a change in memory usage that needs to
> be avoided or announced more explicitely. (and don't change them twice)
See above, I stand corrected. However this patch fixes/restores the buffersize
for setsockopt, but not for the default recieve path. 
Could you please clarify that in the title and description?

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
>>  
>>> - Jan
>>>
>>>>
>>>> Cheers,
>>>> Tony Lu
>>>>
>>>>> Since we now have our own sysctl, which is also exposed to the user,
>>>>> we should sync the logic in a way that both values are the real value
>>>>> used by our code and shown by smc_stats. To achieve this this patch
>>>>> changes the behavior to:
>>>>>
>>>>> default  = net.smc.{w|r}mem (which defaults to net.ipv4.tcp_{w|r}mem[1])
>>>>> sockopt  = the setsockopt mechanism
>>>>> val      = the value assigned in default or via setsockopt
>>>>> sk_buf   = short for sk_{snd|rcv}buf
>>>>> real_buf = the real size of the buffer (sk_buf_size in __smc_buf_create)
>>>>>
>>>>>    exposed   | net/core/sock.c  |    af_smc.c     |  smc_core.c
>>>>>              |                  |                 |
>>>>> +---------+ |                  | +-------------+ | +-----------------+
>>>>> | default |----------------------| sk_buf=val*2|---|real_buf=sk_buf/2|
>>>>> +---------+ |                  | +-------------+ | +-----------------+
>>>>>              |                  |                 |    ^
>>>>>              |                  |                 |    |
>>>>> +---------+ | +--------------+ |                 |    |
>>>>> | sockopt |---| sk_buf=val*2 |------------------------|
>>>>> +---------+ | +--------------+ |                 |
>>>>>              |                  |                 |
>>>>>
>>>>> This way both paths follow the same pattern and the expected behavior
>>>>> is re-established.
>>>>>
>>>>> Fixes: 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock and make them tunable")
>>>>> Signed-off-by: Jan Karcher <jaka@linux.ibm.com>
>>>>> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
>>>>> ---
>>>>>   net/smc/af_smc.c   | 9 +++++++--
>>>>>   net/smc/smc_core.c | 8 ++++----
>>>>>   2 files changed, 11 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
>>>>> index 036532cf39aa..a8c84e7bac99 100644
>>>>> --- a/net/smc/af_smc.c
>>>>> +++ b/net/smc/af_smc.c
>>>>> @@ -366,6 +366,7 @@ static void smc_destruct(struct sock *sk)
>>>>>   static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
>>>>>   				   int protocol)
>>>>>   {
>>>>> +	int buffersize_without_overhead;
>>>>>   	struct smc_sock *smc;
>>>>>   	struct proto *prot;
>>>>>   	struct sock *sk;
>>>>> @@ -379,8 +380,12 @@ static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
>>>>>   	sk->sk_state = SMC_INIT;
>>>>>   	sk->sk_destruct = smc_destruct;
>>>>>   	sk->sk_protocol = protocol;
>>>>> -	WRITE_ONCE(sk->sk_sndbuf, READ_ONCE(net->smc.sysctl_wmem));
>>>>> -	WRITE_ONCE(sk->sk_rcvbuf, READ_ONCE(net->smc.sysctl_rmem));
>>>>> +	buffersize_without_overhead =
>>>>> +		min_t(int, READ_ONCE(net->smc.sysctl_wmem), INT_MAX / 2);
>>>>> +	WRITE_ONCE(sk->sk_sndbuf, buffersize_without_overhead * 2);
>>>>> +	buffersize_without_overhead =
>>>>> +		min_t(int, READ_ONCE(net->smc.sysctl_rmem), INT_MAX / 2);
>>>>> +	WRITE_ONCE(sk->sk_rcvbuf, buffersize_without_overhead * 2);
>>>>>   	smc = smc_sk(sk);
>>>>>   	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
>>>>>   	INIT_WORK(&smc->connect_work, smc_connect_work);
>>>>> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
>>>>> index 00fb352c2765..36850a2ae167 100644
>>>>> --- a/net/smc/smc_core.c
>>>>> +++ b/net/smc/smc_core.c
>>>>> @@ -2314,10 +2314,10 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
>>>>>   	if (is_rmb)
>>>>>   		/* use socket recv buffer size (w/o overhead) as start value */
>>>>> -		sk_buf_size = smc->sk.sk_rcvbuf;
>>>>> +		sk_buf_size = smc->sk.sk_rcvbuf / 2;
>>>>>   	else
>>>>>   		/* use socket send buffer size (w/o overhead) as start value */
>>>>> -		sk_buf_size = smc->sk.sk_sndbuf;
>>>>> +		sk_buf_size = smc->sk.sk_sndbuf / 2;
>>>>>   	for (bufsize_short = smc_compress_bufsize(sk_buf_size, is_smcd, is_rmb);
>>>>>   	     bufsize_short >= 0; bufsize_short--) {
>>>>> @@ -2376,7 +2376,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
>>>>>   	if (is_rmb) {
>>>>>   		conn->rmb_desc = buf_desc;
>>>>>   		conn->rmbe_size_short = bufsize_short;
>>>>> -		smc->sk.sk_rcvbuf = bufsize;
>>>>> +		smc->sk.sk_rcvbuf = bufsize * 2;
>>>>>   		atomic_set(&conn->bytes_to_rcv, 0);
>>>>>   		conn->rmbe_update_limit =
>>>>>   			smc_rmb_wnd_update_limit(buf_desc->len);
>>>>> @@ -2384,7 +2384,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
>>>>>   			smc_ism_set_conn(conn); /* map RMB/smcd_dev to conn */
>>>>>   	} else {
>>>>>   		conn->sndbuf_desc = buf_desc;
>>>>> -		smc->sk.sk_sndbuf = bufsize;
>>>>> +		smc->sk.sk_sndbuf = bufsize * 2;
>>>>>   		atomic_set(&conn->sndbuf_space, bufsize);
>>>>>   	}
>>>>>   	return 0;
>>>>> -- 
>>>>> 2.34.1
