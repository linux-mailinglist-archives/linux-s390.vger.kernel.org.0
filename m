Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B50015D80A
	for <lists+linux-s390@lfdr.de>; Fri, 14 Feb 2020 14:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgBNNMo (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 14 Feb 2020 08:12:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27008 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726191AbgBNNMo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Feb 2020 08:12:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581685963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pyYhZDlasSAUnIVfgkOAQHk5mdpT5dhv3qNAoSJBSsg=;
        b=Vgdd6V+WTRasYsdPmnZITB0RdPmVyzhiNTWUm+jmrHHxABSq04iU2YDEe1e4LYVeRmd38D
        xlLuOdtyBE7qoaOVLGLyRZStcpt6u7Mr5rOCPSb3+6lJ4WAourJrZCz86pTQYaaPUt0y58
        q+oxthZC07LR12BQ/GZUNP0JgQ4pCyE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-ITrltCI-M3SuKOQpuvS2sw-1; Fri, 14 Feb 2020 08:12:39 -0500
X-MC-Unique: ITrltCI-M3SuKOQpuvS2sw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70FDD477;
        Fri, 14 Feb 2020 13:12:37 +0000 (UTC)
Received: from gondolin (dhcp-192-195.str.redhat.com [10.33.192.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1B511001DD8;
        Fri, 14 Feb 2020 13:12:35 +0000 (UTC)
Date:   Fri, 14 Feb 2020 14:12:33 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     qiwuchen55@gmail.com
Cc:     sebott@linux.ibm.com, oberpar@linux.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, linux-s390@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] s390/cio: use kobj_to_dev() API
Message-ID: <20200214141233.1f178637.cohuck@redhat.com>
In-Reply-To: <1581684357-24992-1-git-send-email-qiwuchen55@gmail.com>
References: <1581684357-24992-1-git-send-email-qiwuchen55@gmail.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 14 Feb 2020 20:45:57 +0800
qiwuchen55@gmail.com wrote:

> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> Use kobj_to_dev() API instead of container_of().
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>

I think you should also include the s-o-b from your gmail address here?

> ---
>  drivers/s390/cio/chp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

