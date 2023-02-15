Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277CB698205
	for <lists+linux-s390@lfdr.de>; Wed, 15 Feb 2023 18:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjBORbQ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 15 Feb 2023 12:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjBORbP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Feb 2023 12:31:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA7D3A85C;
        Wed, 15 Feb 2023 09:31:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB646B8231E;
        Wed, 15 Feb 2023 17:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513A3C4339E;
        Wed, 15 Feb 2023 17:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676482271;
        bh=QSoqoR9DXf8LVK4EB1nrN9jFEqhInFYo+9uJuphU45o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p15IV+LU4mVFl1mnzO/+nCb0fnfCz2ETYkB2EXGeYnCcQGhUlkHqKabPR5Pnix7On
         jz5MXQ/4e3+rpa5/4J6BgFsj5WcvAJzuVabWJyU7G0ZUKdO/czoeQNh+tLVarYFaxR
         vhBav6EcLOGoHcJj3Qf1tUXa7fPcHOSkVU03v42VhQ6tVCZtqmtbOfsc+I2bs5G9Xt
         bTJEKW631dacAXQctP6cmR8EcRhqsd7SUdx+HTfmx170XodCzyxSpUD5RRfh1vZAma
         U4aD+bgfFBuunGcqQGGWBf2DhRzOzTyBh/74I8GSJQ9miBxvC2hkljMM//ajHkky4z
         HjS8wfNUyrIyA==
Date:   Wed, 15 Feb 2023 09:31:10 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Wenjia Zhang <wenjia@linux.ibm.com>
Cc:     "D.Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net] net/smc: fix application data exception
Message-ID: <20230215093110.11ea76e8@kernel.org>
In-Reply-To: <ca058775-5fa2-e770-ef32-588bcb84ac6e@linux.ibm.com>
References: <1669450950-27681-1-git-send-email-alibuda@linux.alibaba.com>
        <ca058775-5fa2-e770-ef32-588bcb84ac6e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 15 Feb 2023 10:27:55 +0100 Wenjia Zhang wrote:
> Hi David,
> 
> Thank you for remembering me again about this patch. I did forget to 
> answer you, sorry!
> 
> My consideration was if memzero_explicit() is necessary in this case. 
> But sure, it makes sense, especiall when the dereferencing is in 
> somewhere else.
> 
> Thank you for the fix!
> 
> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>

Thanks! David, please repost if you'd like the patch to be applied to
the networking tree. The original posting is too old to use.
