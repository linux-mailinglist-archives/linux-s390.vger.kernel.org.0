Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37ABD1E2161
	for <lists+linux-s390@lfdr.de>; Tue, 26 May 2020 13:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732028AbgEZLxj (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 26 May 2020 07:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732029AbgEZLxf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 26 May 2020 07:53:35 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39F1C03E97A
        for <linux-s390@vger.kernel.org>; Tue, 26 May 2020 04:53:34 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id a14so20033823ilk.2
        for <linux-s390@vger.kernel.org>; Tue, 26 May 2020 04:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7PyzWO+Jj1rYJeTrMVgBfJHyXjKscWMPYAF4ENdmpbQ=;
        b=ZiSFz2sa/CaJGjkZXg7+XYbmq8A7/o7dYhkWbz41Q7lA0fhDOMtOhIAOpQJsEQR5Ey
         FVuLcjdixB1SN5tTILh/mmh8mSMkRW325fdbKJ2Jif+ywaP1JbIPz5KaUpz6xPbCMstP
         RBuW66rtKY1fNhtM80xDsFGj0TCqwGH6P0CMe1JZnZgD88BekW4Rey1PBi/ibbrkBnzi
         mPUHRc8PdQ7pYX6uJiWhBZNs5paDROkG+0kW7EboK+rKSVOv6hoklNe/nMb9ZmU8szNG
         fgJUGKeBL4GB1543wMPfnImHaExIQ5qweWWrQ29pT4UYIhg6pwq7HbKfvWCb1xZeUzEo
         hKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7PyzWO+Jj1rYJeTrMVgBfJHyXjKscWMPYAF4ENdmpbQ=;
        b=hZ0snyVq7By1G8IcCLqb5PfGBn6iXHHffcKPBvRgndjRf3yxtr9iQQyiwU0JP980pQ
         xEkpfW6sQqFqAyDjAOsNosXBozDrd2UzL7qUfMBLLw86u2FvJF6HtlcxaVPuuD5hkiG2
         8Op72Hysiq7MuJvm3AxBNhWvjBNB9z8bekHNzoys9I/IA48+Mh/K4cVw040B/L+41esp
         oOsvy3qLQSptFLpk6ijVuYrHdWYzz4Fwttu5d3OvGBTDq2/rs8ZKOut2Njbn2njy8eCg
         lMXLNdsW7BQjl9wSUp8jq2JeIn1txhpYotQKFAF1DDBxcJmjn6mSJk36KXsIJ7DwO7GW
         iOyQ==
X-Gm-Message-State: AOAM530UCkwQDevjm5xwBijhlWreJ8G0q77oMeyB6ZR0fsKAvrYA0kVi
        7Xa+H7S5vr/bp0UvqGRyohXhww==
X-Google-Smtp-Source: ABdhPJzIRXhjoFS59ZxVdmc6/72StiajMagnM67AqEd1ZphCwh2n55Z/orX4GwagAuzNM2iGGOZU8A==
X-Received: by 2002:a92:584b:: with SMTP id m72mr662144ilb.119.1590494013995;
        Tue, 26 May 2020 04:53:33 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id e12sm272486ioc.37.2020.05.26.04.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 04:53:33 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH 3/8] greybus: Use the new device_to_pm()
 helper to access struct dev_pm_ops
To:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-pci@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, Kevin Hilman <khilman@kernel.org>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        linux-acpi@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Johan Hovold <johan@kernel.org>, greybus-dev@lists.linaro.org,
        John Stultz <john.stultz@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Felipe Balbi <balbi@kernel.org>, Alex Elder <elder@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Karsten Graul <kgraul@linux.ibm.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
References: <20200525182608.1823735-1-kw@linux.com>
 <20200525182608.1823735-4-kw@linux.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <91707da0-86a8-9e87-efdc-c5a01d259beb@linaro.org>
Date:   Tue, 26 May 2020 06:53:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200525182608.1823735-4-kw@linux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 5/25/20 1:26 PM, Krzysztof Wilczyński wrote:
> Use the new device_to_pm() helper to access Power Management callbacs
> (struct dev_pm_ops) for a particular device (struct device_driver).
> 
> No functional change intended.

Looks fine to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> ---
>   drivers/greybus/bundle.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/greybus/bundle.c b/drivers/greybus/bundle.c
> index 84660729538b..d38d3a630812 100644
> --- a/drivers/greybus/bundle.c
> +++ b/drivers/greybus/bundle.c
> @@ -108,7 +108,7 @@ static void gb_bundle_enable_all_connections(struct gb_bundle *bundle)
>   static int gb_bundle_suspend(struct device *dev)
>   {
>   	struct gb_bundle *bundle = to_gb_bundle(dev);
> -	const struct dev_pm_ops *pm = dev->driver->pm;
> +	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
>   	int ret;
>   
>   	if (pm && pm->runtime_suspend) {
> @@ -135,7 +135,7 @@ static int gb_bundle_suspend(struct device *dev)
>   static int gb_bundle_resume(struct device *dev)
>   {
>   	struct gb_bundle *bundle = to_gb_bundle(dev);
> -	const struct dev_pm_ops *pm = dev->driver->pm;
> +	const struct dev_pm_ops *pm = driver_to_pm(dev->driver);
>   	int ret;
>   
>   	ret = gb_control_bundle_resume(bundle->intf->control, bundle->id);
> 

