Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F1C72F702
	for <lists+linux-s390@lfdr.de>; Wed, 14 Jun 2023 09:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243601AbjFNHyN (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 14 Jun 2023 03:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjFNHxo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 14 Jun 2023 03:53:44 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD821FEE;
        Wed, 14 Jun 2023 00:52:54 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0Vl5j8IK_1686729132;
Received: from 30.221.151.14(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0Vl5j8IK_1686729132)
          by smtp.aliyun-inc.com;
          Wed, 14 Jun 2023 15:52:17 +0800
Message-ID: <0bea9ac1-dd44-353b-63dd-a3dd45b588e1@linux.alibaba.com>
Date:   Wed, 14 Jun 2023 15:52:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] MAINTAINERS: add reviewers for SMC Sockets
Content-Language: en-US
To:     Jan Karcher <jaka@linux.ibm.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Nils Hoppmann <niho@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>
References: <20230614065456.2724-1-jaka@linux.ibm.com>
From:   "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20230614065456.2724-1-jaka@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On 6/14/23 2:54 PM, Jan Karcher wrote:
> adding three people from Alibaba as reviewers for SMC.
> They are currently working on improving SMC on other architectures than
> s390 and help with reviewing patches on top.
>
> Thank you D. Wythe, Tony Lu and Wen Gu for your contributions and
> collaboration and welcome on board as reviewers!

Thanks for inviting me. I'm happy to become a reviewer for SMC .
I will do my best to provide the best help and support. 😁

Acked-by: D. Wythe <alibuda@linux.alibaba.com>

> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> Signed-off-by: Jan Karcher <jaka@linux.ibm.com>
> ---
>   MAINTAINERS | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f794002a192e..6992b7cc7095 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19140,6 +19140,9 @@ SHARED MEMORY COMMUNICATIONS (SMC) SOCKETS
>   M:	Karsten Graul <kgraul@linux.ibm.com>
>   M:	Wenjia Zhang <wenjia@linux.ibm.com>
>   M:	Jan Karcher <jaka@linux.ibm.com>
> +R:	D. Wythe <alibuda@linux.alibaba.com>
> +R:	Tony Lu <tonylu@linux.alibaba.com>
> +R:	Wen Gu <guwen@linux.alibaba.com>
>   L:	linux-s390@vger.kernel.org
>   S:	Supported
>   F:	net/smc/

