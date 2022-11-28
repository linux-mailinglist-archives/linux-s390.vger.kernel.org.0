Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27E4563A09D
	for <lists+linux-s390@lfdr.de>; Mon, 28 Nov 2022 05:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiK1Eds (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 27 Nov 2022 23:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiK1Edq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 27 Nov 2022 23:33:46 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13AE6376;
        Sun, 27 Nov 2022 20:33:42 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VVnfHB4_1669610019;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0VVnfHB4_1669610019)
          by smtp.aliyun-inc.com;
          Mon, 28 Nov 2022 12:33:40 +0800
Date:   Mon, 28 Nov 2022 12:33:36 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     Alexandra Winter <wintera@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>
Subject: Re: [PATCH net] net/smc: Fix expected buffersizes and sync logic
Message-ID: <Y4Q6IKPF4qw4EDBd@TonyMac-Alibaba>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <20221123104907.14624-1-jaka@linux.ibm.com>
 <Y34JxFWBdUxvLQb4@TonyMac-Alibaba>
 <40428548-59b9-379c-857c-172db92afc0c@linux.ibm.com>
 <Y34i8nmJIeIiFuOP@TonyMac-Alibaba>
 <f5237afd-d57b-f317-4263-31b4bb3d0d17@linux.ibm.com>
 <1a36b6ba-e7bb-6f2a-c460-cf158cb64b1d@linux.ibm.com>
 <a6e57be8-48e3-acf7-8474-fc9b81cd6615@linux.ibm.com>
 <Y4BpNfg7yxRiYQuU@TonyMac-Alibaba>
 <7e0baa06-74e3-e00a-861a-afa8fe1fbdff@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e0baa06-74e3-e00a-861a-afa8fe1fbdff@linux.ibm.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Nov 25, 2022 at 11:59:46AM +0100, Alexandra Winter wrote:
> 
> 
> On 25.11.22 08:05, Tony Lu wrote:
> > On Fri, Nov 25, 2022 at 07:15:33AM +0100, Jan Karcher wrote:
> >>
> >>
> >> On 24/11/2022 15:07, Alexandra Winter wrote:
> >>>
> >>>
> >>> On 24.11.22 14:00, Alexandra Winter wrote:
> >>>>
> >>>>
> >> [ ... ]>>>>> On Wed, Nov 23, 2022 at 11:49:07AM +0100, Jan Karcher wrote:
> >>>>>>>> The fixed commit changed the expected behavior of buffersizes
> >>>>>>>> set by the user using the setsockopt mechanism.
> >>>>>>>> Before the fixed patch the logic for determining the buffersizes used
> >>>>>>>> was the following:
> >>>>>>>>
> >>>>>>>> default  = net.ipv4.tcp_{w|r}mem[1]
> >>> Jan, you explained to me: "the minima is 16Kib. This is enforced in smc_compress_bufsize
> >>> which would move any value <= 16Kib into bucket 0 - which is 16KiB "
> >>> net.ipv4.tcp_wmem[1] defaults to 8Kib. So in the default case (unchanged net.ipv4.tcp_wmem[1])
> >>> the default for the send path is not net.ipv4.tcp_wmem[1]. Should be clarified here.
> >>
> >> The default value is still set to the net.ipv4.tcp_{w|r}mem[1]. This is a
> >> *very* top level overview about what is happening and *not* a documentation.
> >> I don't really want to explain the full code flow here.
> >>
> >> What we still should do - as Tony aggreed on - is documenting the SMC
> >> behavior. This is a follow up on my list.
> > 
> > Hello Jan and Alexandra,
> > 
> > It looks like the misalignment of information is causing some trouble,
> > which is introduced by my patch. Maybe we could have an off-maillist and
> > online meeting to discussion?
> > 
> > We have some progress updates of scalability, and we are really like the
> > extension of SMC-D. Also we have some ideas for SMC, in case of
> > misalignment of information, we'd like to put them on the table and
> > discuss them earlier. Maybe an online meeting is an efficient way. What
> > do you think?
> > 
> > If possible, I would prepared the meetings and topics and send them to
> > everyone first.
> > 
> > Cheers,
> > Tony Lu
> > 
> 
> Thanks a lot for your constructive proposals Tony. Yes, we should have a discussion off-mailinglist
> about future topics.

I will prepare the discussion off-maillinglist ASAP. The email will be
sent out when it's ready. And Jan, What about your opinion?

Cheers,
Tony Lu

> 
> My remaining concern for this fix is the default values (user does not use setsockopt, nor 
> changes the new sysfs parameters, nor changes tcp defaults):
> >>>> before 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock and make them tunable")
> 	    send: 16k recv: 64k
> >>>> after net/smc: Fix expected buffersizes and sync logic   (this patch)
> >>>>       send: 16k recv: 128k
> 
> @Jan, as this is the only patch you want to send to net, please change the default size of
> the receive buffers back to 64k (I don't care how).
> 
> 
> >>
> >>>>>>>> sockopt  = the setsockopt mechanism
> >>>>>>>> val      = the value assigned in default or via setsockopt
> >>>>>>>> sk_buf   = short for sk_{snd|rcv}buf
> >>>>>>>> real_buf = the real size of the buffer (sk_buf_size in __smc_buf_create)
> >>>>>>>>
> >>>>>>>>     exposed   | net/core/sock.c  |    af_smc.c    |  smc_core.c
> >>>>>>>>               |                  |                |
> >>>>>>>> +---------+ |                  | +------------+ | +-------------------+
> >>>>>>>> | default |----------------------| sk_buf=val |---| real_buf=sk_buf/2 |
> >>>>>>>> +---------+ |                  | +------------+ | +-------------------+
> >>>>>>>>               |                  |                |    ^
> >>>>>>>>               |                  |                |    |
> >>>>>>>> +---------+ | +--------------+ |                |    |
> >>>>>>>> | sockopt |---| sk_buf=val*2 |-----------------------|
> >>>>>>>> +---------+ | +--------------+ |                |
> >>>>>>>>               |                  |                |
> >>>>>>>>
> >>>>>>>> The fixed patch introduced a dedicated sysctl for smc
> >>>>>>>> and removed the /2 in smc_core.c resulting in the following flow:
> >>>>>>>>
> >>>>>>>> default  = net.smc.{w|r}mem (which defaults to net.ipv4.tcp_{w|r}mem[1])
> >>>>>>>> sockopt  = the setsockopt mechanism
> >>>>>>>> val      = the value assigned in default or via setsockopt
> >>>>>>>> sk_buf   = short for sk_{snd|rcv}buf
> >>>>>>>> real_buf = the real size of the buffer (sk_buf_size in __smc_buf_create)
> >>>>>>>>
> >>>>>>>>     exposed   | net/core/sock.c  |    af_smc.c    |  smc_core.c
> >>>>>>>>               |                  |                |
> >>>>>>>> +---------+ |                  | +------------+ | +-----------------+
> >>>>>>>> | default |----------------------| sk_buf=val |---| real_buf=sk_buf |
> >>>>>>>> +---------+ |                  | +------------+ | +-----------------+
> >>>>>>>>               |                  |                |    ^
> >>>>>>>>               |                  |                |    |
> >>>>>>>> +---------+ | +--------------+ |                |    |
> >>>>>>>> | sockopt |---| sk_buf=val*2 |-----------------------|
> >>>>>>>> +---------+ | +--------------+ |                |
> >>>>>>>>               |                  |                |
> >>>>>>>>
> >>>>>>>> This would result in double of memory used for existing configurations
> >>>>>>>> that are using setsockopt.
> >>>>>>>
> >>>>>>> Firstly, thanks for your detailed diagrams :-)
> >>>>>>>
> >>>>>>> And the original decision to use user-provided values rather than
> >>>>>>> value/2 to follow the instructions of the socket manual [1].
> >>>>>>>
> >>>>>>>     SO_RCVBUF
> >>>>>>>            Sets or gets the maximum socket receive buffer in bytes.
> >>>>>>>            The kernel doubles this value (to allow space for
> >>>>>>>            bookkeeping overhead) when it is set using setsockopt(2),
> >>>>>>>            and this doubled value is returned by getsockopt(2).  The
> >>>>>>>            default value is set by the
> >>>>>>>            /proc/sys/net/core/rmem_default file, and the maximum
> >>>>>>>            allowed value is set by the /proc/sys/net/core/rmem_max
> >>>>>>>            file.  The minimum (doubled) value for this option is 256.
> >>>>>>>
> >>>>>>> [1] https://man7.org/linux/man-pages/man7/socket.7.html
> >>>>>>>
> >>>>>>> The user of SMC should know that setsockopt() with SO_{RCV|SND}BUF will
> >>>>>>
> >>>>>> I totally agree that an educated user of SMC should know about that behavior
> >>>>>> if they decide to use it.
> >>>>>> We do provide our users preload libraries where they can pass preferred
> >>>>>> buffersizes via arguments and we handle the Sockopts for them.
> >>>>>>
> >>>>>>> double the values in kernel, and getsockopt() will return the doubled
> >>>>>>> values. So that they should use half of the values which are passed to
> >>>>>>> setsockopt(). The original patch tries to make things easier in SMC and
> >>>>>>> let user-space to handle them following the socket manual.
> >>>>>>>
> >>>>>>>> SMC historically decided to use the explicit value given by the user
> >>>>>>>> to allocate the memory. This is why we used the /2 in smc_core.c.
> >>>>>>>> That logic was not applied to the default value.
> >>>>>>>
> >>>>>>> Yep, let back to the patch which introduced smc_{w|r}mem knobs, it's a
> >>>>>>> trade-off to follow original logic of SMC, or follow the socket manual.
> >>>>>>> We decides to follow the instruction of manuals in the end.
> >>>>>>
> >>>>>> I understand the point. I spend a lot of time trying to decide what to do.
> >>>>>>
> >>>>>> Since it was an intentional decision to not follow the general socket
> >>>>>> option, and we do not have anyone complaining we do not really have a reason
> >>>>>> to change it.
> >>>>>> Changing it means that users with existing configurations would have to
> >>>>>> change their configs on an update or suddenly expect double the memory
> >>>>>> consumption.
> >>>>>> That's why we in the end preffered to stay with the current logic.
> >>>>>
> >>>>> I can't agree with you more with the points to follow the historic logic
> >>>>> and not break the user-space applications.
> >>>>>
> >>>>>> I'm thinking that maybe - if we stay with the historic logic - we should
> >>>>>> document that desicion somewhere. So that in the future, if a user that
> >>>>>> expects the man page behavior, has a way to understand what SMC is doing.
> >>>>>> What do oyu think?
> >>>>>
> >>>>> Yep, we _really_ need to document it if we change the convention.
> >>>>> Actually, I spent a lot of time to find the history about the logic of
> >>>>> buffer (/2 and *2) in SMC. So I'm really in favor of adding
> >>>>> documentation, at least code comments to help others to understand them.
> >>>>>
> >>>>> Cheers,
> >>>>> Tony Lu
> >>>> Iiuc you are changing the default values in this a patch and your other patch:
> >>>> Default values for real_buf for send and receive:
> >>>>
> >>>> before 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock and make them tunable")
> >>>>      real_buf=net.ipv4.tcp_{w|r}mem[1]/2   send: 8k  recv: 64k
> >>>        see above: 			    send: 16k recv: 64k
> >>>> after 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock and make them tunable")
> >>>> real_buf=net.ipv4.tcp_{w|r}mem[1]   send: 16k (16*1024) recv: 128k (131072)
> >>>>
> >>>> after net/smc: Fix expected buffersizes and sync logic
> >>>> real_buf=net.ipv4.tcp_{w|r}mem[1]   send: 16k (16*1024) recv: 128k (131072)
> >>>>
> >>>> after net/smc: Unbind smc control from tcp control
> >>>> real_buf=SMC_*BUF_INIT_SIZE   send: 16k (16384) recv: 64k (65536)
> >>>>
> >>>> If my understanding is correct, then I nack this.
> >>>> Defaults should be restored to the values before 0227f058aa29.
> >>>> Otherwise users will notice a change in memory usage that needs to
> >>>> be avoided or announced more explicitely. (and don't change them twice)
> >>> See above, I stand corrected. However this patch fixes/restores the buffersize
> >>> for setsockopt, but not for the default recieve path.
> >>> Could you please clarify that in the title and description?
> >>>
> >>
> >> I am trying to keep the commit title as crisp as possible while providing
> >> enough information and set the context in the commit message:
> >>
> >> "The fixed commit changed the expected behavior of buffersizes set by the
> >> user using the setsockopt mechanism."
> >>
> >>  + There is now a whole e-mail thread to consult in case of any further
> >> questions.
> >>
> >> Thank you for your comments
> >> - Jan
> >>
> >>> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> >>>>>> - Jan
> >>>>>>
> >>>>>>>
> >>>>>>> Cheers,
> >>>>>>> Tony Lu
> >>>>>>>
> >>>>>>>> Since we now have our own sysctl, which is also exposed to the user,
> >>>>>>>> we should sync the logic in a way that both values are the real value
> >>>>>>>> used by our code and shown by smc_stats. To achieve this this patch
> >>>>>>>> changes the behavior to:
> >>>>>>>>
> >>>>>>>> default  = net.smc.{w|r}mem (which defaults to net.ipv4.tcp_{w|r}mem[1])
> >>>>>>>> sockopt  = the setsockopt mechanism
> >>>>>>>> val      = the value assigned in default or via setsockopt
> >>>>>>>> sk_buf   = short for sk_{snd|rcv}buf
> >>>>>>>> real_buf = the real size of the buffer (sk_buf_size in __smc_buf_create)
> >>>>>>>>
> >>>>>>>>     exposed   | net/core/sock.c  |    af_smc.c     |  smc_core.c
> >>>>>>>>               |                  |                 |
> >>>>>>>> +---------+ |                  | +-------------+ | +-----------------+
> >>>>>>>> | default |----------------------| sk_buf=val*2|---|real_buf=sk_buf/2|
> >>>>>>>> +---------+ |                  | +-------------+ | +-----------------+
> >>>>>>>>               |                  |                 |    ^
> >>>>>>>>               |                  |                 |    |
> >>>>>>>> +---------+ | +--------------+ |                 |    |
> >>>>>>>> | sockopt |---| sk_buf=val*2 |------------------------|
> >>>>>>>> +---------+ | +--------------+ |                 |
> >>>>>>>>               |                  |                 |
> >>>>>>>>
> >>>>>>>> This way both paths follow the same pattern and the expected behavior
> >>>>>>>> is re-established.
> >>>>>>>>
> >>>>>>>> Fixes: 0227f058aa29 ("net/smc: Unbind r/w buffer size from clcsock and make them tunable")
> >>>>>>>> Signed-off-by: Jan Karcher <jaka@linux.ibm.com>
> >>>>>>>> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> >>>>>>>> ---
> >>>>>>>>    net/smc/af_smc.c   | 9 +++++++--
> >>>>>>>>    net/smc/smc_core.c | 8 ++++----
> >>>>>>>>    2 files changed, 11 insertions(+), 6 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> >>>>>>>> index 036532cf39aa..a8c84e7bac99 100644
> >>>>>>>> --- a/net/smc/af_smc.c
> >>>>>>>> +++ b/net/smc/af_smc.c
> >>>>>>>> @@ -366,6 +366,7 @@ static void smc_destruct(struct sock *sk)
> >>>>>>>>    static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
> >>>>>>>>    				   int protocol)
> >>>>>>>>    {
> >>>>>>>> +	int buffersize_without_overhead;
> >>>>>>>>    	struct smc_sock *smc;
> >>>>>>>>    	struct proto *prot;
> >>>>>>>>    	struct sock *sk;
> >>>>>>>> @@ -379,8 +380,12 @@ static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
> >>>>>>>>    	sk->sk_state = SMC_INIT;
> >>>>>>>>    	sk->sk_destruct = smc_destruct;
> >>>>>>>>    	sk->sk_protocol = protocol;
> >>>>>>>> -	WRITE_ONCE(sk->sk_sndbuf, READ_ONCE(net->smc.sysctl_wmem));
> >>>>>>>> -	WRITE_ONCE(sk->sk_rcvbuf, READ_ONCE(net->smc.sysctl_rmem));
> >>>>>>>> +	buffersize_without_overhead =
> >>>>>>>> +		min_t(int, READ_ONCE(net->smc.sysctl_wmem), INT_MAX / 2);
> >>>>>>>> +	WRITE_ONCE(sk->sk_sndbuf, buffersize_without_overhead * 2);
> >>>>>>>> +	buffersize_without_overhead =
> >>>>>>>> +		min_t(int, READ_ONCE(net->smc.sysctl_rmem), INT_MAX / 2);
> >>>>>>>> +	WRITE_ONCE(sk->sk_rcvbuf, buffersize_without_overhead * 2);
> >>>>>>>>    	smc = smc_sk(sk);
> >>>>>>>>    	INIT_WORK(&smc->tcp_listen_work, smc_tcp_listen_work);
> >>>>>>>>    	INIT_WORK(&smc->connect_work, smc_connect_work);
> >>>>>>>> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> >>>>>>>> index 00fb352c2765..36850a2ae167 100644
> >>>>>>>> --- a/net/smc/smc_core.c
> >>>>>>>> +++ b/net/smc/smc_core.c
> >>>>>>>> @@ -2314,10 +2314,10 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
> >>>>>>>>    	if (is_rmb)
> >>>>>>>>    		/* use socket recv buffer size (w/o overhead) as start value */
> >>>>>>>> -		sk_buf_size = smc->sk.sk_rcvbuf;
> >>>>>>>> +		sk_buf_size = smc->sk.sk_rcvbuf / 2;
> >>>>>>>>    	else
> >>>>>>>>    		/* use socket send buffer size (w/o overhead) as start value */
> >>>>>>>> -		sk_buf_size = smc->sk.sk_sndbuf;
> >>>>>>>> +		sk_buf_size = smc->sk.sk_sndbuf / 2;
> >>>>>>>>    	for (bufsize_short = smc_compress_bufsize(sk_buf_size, is_smcd, is_rmb);
> >>>>>>>>    	     bufsize_short >= 0; bufsize_short--) {
> >>>>>>>> @@ -2376,7 +2376,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
> >>>>>>>>    	if (is_rmb) {
> >>>>>>>>    		conn->rmb_desc = buf_desc;
> >>>>>>>>    		conn->rmbe_size_short = bufsize_short;
> >>>>>>>> -		smc->sk.sk_rcvbuf = bufsize;
> >>>>>>>> +		smc->sk.sk_rcvbuf = bufsize * 2;
> >>>>>>>>    		atomic_set(&conn->bytes_to_rcv, 0);
> >>>>>>>>    		conn->rmbe_update_limit =
> >>>>>>>>    			smc_rmb_wnd_update_limit(buf_desc->len);
> >>>>>>>> @@ -2384,7 +2384,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
> >>>>>>>>    			smc_ism_set_conn(conn); /* map RMB/smcd_dev to conn */
> >>>>>>>>    	} else {
> >>>>>>>>    		conn->sndbuf_desc = buf_desc;
> >>>>>>>> -		smc->sk.sk_sndbuf = bufsize;
> >>>>>>>> +		smc->sk.sk_sndbuf = bufsize * 2;
> >>>>>>>>    		atomic_set(&conn->sndbuf_space, bufsize);
> >>>>>>>>    	}
> >>>>>>>>    	return 0;
> >>>>>>>> -- 
> >>>>>>>> 2.34.1
